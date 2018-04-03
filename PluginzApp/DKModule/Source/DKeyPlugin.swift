//
//  DKeyPlugin.swift
//  DKModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

struct DKeyPrimaryPluginFactory: TilePluginFactory {
    static var identifier: String { return "DKEY_PRIMARY" }
    
    static func registerPlugin(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        
        guard let dKeyStay = stay as? DKeyStay else {
            updateBlock(identifier, nil, nil)
            return
        }
        
        var plugin: DKeyPlugin?
        switch dKeyStay.keyStatus {
        case .learnMore:
            plugin = DKeyPlugin.learnMore(stay: dKeyStay, identifier: identifier, updateBlock: updateBlock)
        case .requestKey:
            plugin = DKeyPlugin.requestKey(stay: dKeyStay, identifier: identifier, updateBlock: updateBlock)
        case .requested:
            plugin = DKeyPlugin.requested(stay: dKeyStay, identifier: identifier, updateBlock: updateBlock)
        case .liveKey:
            plugin = DKeyPlugin.liveKey(stay: dKeyStay, identifier: identifier, updateBlock: updateBlock)
        default:
            break
        }
        
        updateBlock(identifier, plugin, nil)
    }
    
}

enum DKeyPlugin: TilePlugin {
    case learnMore(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    case requestKey(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    case requested(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    case liveKey(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    
    var identifier: String {
        switch self {
        case .learnMore(_, let identifier, _): return identifier
        case .requestKey(_, let identifier, _): return identifier
        case .requested(_, let identifier, _): return identifier
        case .liveKey(_, let identifier, _): return identifier
        }
    }
    
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
    
    func performAction(sender: UIViewController?) {
        guard let vc = sender else { return }
        
        switch self {
        case .learnMore:
            let dKeyVC = DKeyViewController()
            dKeyVC.text = "Learn how to use a digital key!"
            vc.present(dKeyVC, animated: true, completion: nil)
            
        case .requestKey(var stay, _, let updateBlock):
            let dKeyVC = DKeyViewController()
            dKeyVC.text = "You can request a key now!"
            dKeyVC.buttonText = "Request Key"
            dKeyVC.completion = {
                stay.keyStatus = .requested
                DKeyModule.keyRequested(stay: stay, updateBlock: updateBlock)
                
                // Simulate key being delivered after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    stay.keyStatus = .liveKey
                    DKeyModule.keyDelivered(stay: stay, updateBlock: updateBlock)
                }
            }
            vc.present(dKeyVC, animated: true, completion: nil)
          
        case .requested:
            break
            
        case .liveKey:
            let keyCardVC = DKeyLiveKeyViewController()
            vc.present(keyCardVC, animated: true, completion: nil)
    
        }
        
    }
    
}
