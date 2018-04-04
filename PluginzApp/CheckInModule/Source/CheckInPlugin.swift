//
//  CheckInPluginFactory.swift
//  CheckInModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

struct CheckInPluginFactory<T>: TilePluginFactory where T: CheckInStay {
    static var identifier: String { return "CHECK_IN" }
    typealias PluginStay = T
    static func registerPlugin(forStay stay: PluginStay, module: CheckInModule<T>, updateBlock: @escaping TilePluginUpdateBlock) {
        guard
            stay.checkInAvailable else {
            updateBlock(identifier, nil, nil)
            return
        }
        
        let plugin = CheckInPlugin.checkIn(stay: stay, identifier: identifier, module: module, updateBlock: updateBlock)
        updateBlock(identifier, plugin, nil)
    }
    
}

enum CheckInPlugin<T>: TilePlugin where T: CheckInStay {
    case checkIn(stay: T, identifier: String, module: CheckInModule<T>, updateBlock: TilePluginUpdateBlock)
    
    var identifier: String {
        switch self {
        case .checkIn(_, let identifier, _, _):
            return identifier
        }
    }
    
    var accessibilityId: String { return "UIA_CheckInTile" }
    
    var title: String? { return "Check In" }
    
    var icon: UIImage? { return UIImage(named:"fullcard_checkinAvail") }
    
    func performAction(sender: UIViewController?) {
        
        switch self {
        case .checkIn(var stay, _, let module, let updateBlock):
            
            guard let vc = sender else { return }
            let checkInVC = CheckInViewController()
            checkInVC.completion = {
                stay.checkInAvailable = false
                module.checkInCompleted(stay: stay, updateBlock: updateBlock)
            }
            
            vc.present(checkInVC, animated: true, completion: nil)
        }
        
    }
    
}
