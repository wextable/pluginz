//
//  DKeyPlugin.swift
//  DKModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

extension DKeyStay {
    var undeliveredKeyStatus: DKeyStatus? {
        guard let keyStatuses = (segments as? [DKeySegment])?.flatMap({ $0.keyStatus }) else { return nil }
        
        if keyStatuses.contains(.requested) {
            return .requested
        } else if keyStatuses.contains(.requestKey) {
            return .requestKey
        } else if keyStatuses.contains(.learnMore) {
            return .learnMore
        }
        return nil
    }
}

struct DKeyPrimaryPlugin: TilePlugin {
    static var identifier: String { return "DKEY_PRIMARY" }
    
    static func fetchTile(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        
        guard let dKeyStay = stay as? DKeyStay else {
            updateBlock(identifier, nil, nil)
            return
        }
        
        var tile: DKeyPluginTile?
        
        if dKeyStay.hasKey {
            tile = DKeyPluginTile.liveKey(stay: dKeyStay, updateBlock: updateBlock)
        } else if let keyStatus = dKeyStay.undeliveredKeyStatus {
            switch keyStatus {
            case .learnMore:
                tile = DKeyPluginTile.learnMore(stay: dKeyStay, updateBlock: updateBlock)
            case .requestKey:
                if let segment = (dKeyStay.segments as? [DKeySegment])?.first(where: { $0.keyStatus == .requestKey }) {
                    tile = DKeyPluginTile.requestKey(stay: dKeyStay, segment: segment, updateBlock: updateBlock)
                }
            case .requested:
                tile = DKeyPluginTile.requested(stay: dKeyStay, updateBlock: updateBlock)
            default:
                break
            }
        }

        updateBlock(identifier, tile, nil)
    }
    
}

struct DKeySecondaryPlugin: TilePlugin {
    static var identifier: String { return "DKEY_SECONDARY" }
    
    static func fetchTile(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        
        guard let dKeyStay = stay as? DKeyStay,
            dKeyStay.hasKey else {
            updateBlock(identifier, nil, nil)
            return
        }
        
        var tile: DKeyPluginTile?
        
         if let keyStatus = dKeyStay.undeliveredKeyStatus {
            switch keyStatus {            
            case .requestKey:
                if let segment = (dKeyStay.segments as? [DKeySegment])?.first(where: { $0.keyStatus == .requestKey }) {
                    tile = DKeyPluginTile.requestKey(stay: dKeyStay, segment: segment, updateBlock: updateBlock)
                }
            case .requested:
                tile = DKeyPluginTile.requested(stay: dKeyStay, updateBlock: updateBlock)
            default:
                break
            }
        }
        
        updateBlock(identifier, tile, nil)
    }
    
}

enum DKeyPluginTile: PluginTile {
    case learnMore(stay: DKeyStay, updateBlock: TilePluginUpdateBlock)
    case requestKey(stay: DKeyStay, segment: DKeySegment, updateBlock: TilePluginUpdateBlock)
    case requested(stay: DKeyStay, updateBlock: TilePluginUpdateBlock)
    case liveKey(stay: DKeyStay, updateBlock: TilePluginUpdateBlock)
    
    var accessibilityId: String {
        switch self {
        case .learnMore:
            return "UIA_LearnMoreTile"
        case .requestKey:
            return "UIA_RequestKeyTile"
        case .requested:
            return "UIA_KeyRequestedTile"
        case .liveKey:
            return "UIA_DKeyTile"
        }
    }
    
    var title: String? {
        switch self {
        case .learnMore:
            return "Learn More"
        case .requestKey:
            return "Request Key"
        case .requested:
            return "Key Requested"
        case .liveKey:
            return "Digital Key"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .learnMore:
            return UIImage(named:"fullcard_dkOutline")
        case .requestKey:
            return UIImage(named:"fullcard_dkRequest")
        case .requested:
            return UIImage(named:"fullcard_dkRequest")
        case .liveKey:
            return UIImage(named:"fullcard_dkSolid")
        }
    }
    
    var iconTintColor: UIColor? {
        switch self {
        case .liveKey:
            return .white
        default:
            return .blue
        }
    }
    
    var backgroundImage: UIImage? {
        switch self {
        case .liveKey:
            return UIImage(named:"fullcard_dk_green_bg")
        default:
            return nil
        }
    }
    
    var routableDeeplinks: [String] {
        switch self {
        case .learnMore:
            return ["learnMore"]
        case .requestKey:
            return ["requestKey"]
        case .requested:
            return []
        case .liveKey:
            return ["key"]
        }
    }
    
    func performAction(sender: UIViewController?) {
        guard let vc = sender else { return }
        
        switch self {
        case .learnMore:
            let dKeyVC = DKeyViewController()
            dKeyVC.text = "Learn how to use a digital key!"
            vc.present(dKeyVC, animated: true, completion: nil)
            
        case .requestKey(let stay, let segment, let updateBlock):
            let dKeyVC = DKeyViewController()
            dKeyVC.text = "You can request a key now for room \(segment.segmentNumber)"
            dKeyVC.buttonText = "Request Key"
            dKeyVC.completion = {
                DKeyModule.keyRequested(stay: stay, segment: segment, updateBlock: updateBlock)
                
                // Simulate key being delivered after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    DKeyModule.keyDelivered(stay: stay, segment: segment, updateBlock: updateBlock)
                }
            }
            vc.present(dKeyVC, animated: true, completion: nil)
          
        case .requested:
            break
            
        case .liveKey(let stay, _):
            let keyCardVC = DKeyLiveKeyViewController()
            if let dKeySegments = stay.segments as? [DKeySegment] {
                let roomNames: [String] = dKeySegments.filter { $0.keyStatus == .delivered }
                    .flatMap { $0.segmentNumber }
                keyCardVC.roomNames = roomNames
            }
            vc.present(keyCardVC, animated: true, completion: nil)
    
        }
        
    }
    
}
