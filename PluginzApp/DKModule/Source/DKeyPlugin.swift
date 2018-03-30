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
        
        let plugin = DKeyPlugin.dKey(stay: dKeyStay, identifier: identifier, updateBlock: updateBlock)
        updateBlock(identifier, plugin, nil)
    }
    
}

enum DKeyPlugin: TilePlugin {
    case learnMore(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    case canRequest(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    case requested(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    case liveKey(stay: DKeyStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    
    var identifier: String {
        switch self {
        case .learnMore(_, let identifier, _): return identifier
        case .canRequest(_, let identifier, _): return identifier
        case .requested(_, let identifier, _): return identifier
        case .liveKey(_, let identifier, _): return identifier
        }
    }
    
    var accessibilityId: String {
        switch self {
        case .learnMore:
            return "UIA_LearnMoreTile"
        case .canRequest:
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
        case .canRequest:
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
        case .canRequest:
            return UIImage(named:"fullcard_dkRequest")
        case .requested:
            return UIImage(named:"fullcard_dkRequest")
        case .liveKey:
            return UIImage(named:"fullcard_dkSolid")
        }
    }
    
    
    func performAction(sender: UIViewController?) {
        
//        switch self {
//        case .learnMore(var stay, _, let updateBlock):
        
//            guard let vc = sender else { return }
//            let dKeyVC = DKeyViewController()
//            dKeyVC.completion = {
//                stay.dKeyAvailable = false
//                DKeyModule.dKeyCompleted(stay: stay, updateBlock: updateBlock)
//            }
//
//            vc.present(dKeyVC, animated: true, completion: nil)
//        }
        
    }
    
}
