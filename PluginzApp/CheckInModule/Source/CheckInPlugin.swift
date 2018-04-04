//
//  CheckInPluginFactory.swift
//  CheckInModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

struct CheckInPluginFactory: TilePluginFactory {
    static var identifier: String { return "CHECK_IN" }
    
    static func registerPlugin(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        
        guard let segments = stay.segments as? [CheckInSegment],
            let segment = segments.first(where: { $0.checkInAvailable }) else {
            updateBlock(identifier, nil, nil)
            return
        }
        
        let plugin = CheckInPlugin.checkIn(stay: stay, segment: segment, identifier: identifier, updateBlock: updateBlock)
        updateBlock(identifier, plugin, nil)
    }
    
}

enum CheckInPlugin: TilePlugin {
    case checkIn(stay: TilePluginStay, segment: TilePluginSegment, identifier: String, updateBlock: TilePluginUpdateBlock)
    
    var identifier: String {
        switch self {
        case .checkIn(_, _, let identifier, _):
            return identifier
        }
    }
    
    var accessibilityId: String { return "UIA_CheckInTile" }
    
    var title: String? { return "Check In" }
    
    var icon: UIImage? { return UIImage(named:"fullcard_checkinAvail") }
    
    func performAction(sender: UIViewController?) {
        
        switch self {
        case .checkIn(let stay, let segment, _, let updateBlock):
            
            guard let vc = sender else { return }
            let checkInVC = CheckInViewController()
            checkInVC.completion = {
                CheckInModule.checkInCompleted(stay: stay, segment: segment, updateBlock: updateBlock)
            }
            
            vc.present(checkInVC, animated: true, completion: nil)
        }
        
    }
    
}
