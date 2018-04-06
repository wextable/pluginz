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
    static var order: Int = -1
    
    static func registerPlugin(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        
        guard let segments = stay.segments as? [CheckInSegment],
            let segment = segments.first(where: { $0.checkInAvailable }) else {
            updateBlock(identifier, nil, nil)
            return
        }
        
        let plugin = CheckInPlugin.checkIn(stay: stay, segment: segment, order: order, updateBlock: updateBlock)
        updateBlock(identifier, plugin, nil)
    }
    
}

enum CheckInPlugin: TilePlugin {
    case checkIn(stay: TilePluginStay, segment: TilePluginSegment, order: Int, updateBlock: TilePluginUpdateBlock)
    
    var order: Int {
        switch self {
        case .checkIn(_, _, let order, _):  return order
        }
    }
    
    var accessibilityId: String { return "UIA_CheckInTile" }
    
    var title: String? { return "Check In" }
    
    var icon: UIImage? { return UIImage(named:"fullcard_checkinAvail") }
    
    var routableDeeplinks: [String] { return ["checkIn"] }
    
    func performAction(sender: UIViewController?) {
        
        switch self {
        case .checkIn(let stay, let segment, _, let updateBlock):
            
            guard let vc = sender else { return }
            let checkInVC = CheckInViewController()
            checkInVC.roomName = segment.segmentNumber
            checkInVC.completion = {
                CheckInModule.checkInCompleted(stay: stay, segment: segment, updateBlock: updateBlock)
            }
            
            vc.present(checkInVC, animated: true, completion: nil)
        }
        
    }
    
}
