//
//  CheckInTilePlugin.swift
//  CheckInModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

struct CheckInTilePlugin: TilePlugin {
    static var identifier: String { return "CHECK_IN" }
    
    static func fetchTile(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        
        guard let segments = stay.segments as? [CheckInSegment],
            let segment = segments.first(where: { $0.checkInAvailable }) else {
            updateBlock(identifier, nil, nil)
            return
        }
        
        let plugin = CheckInPlugin.checkIn(stay: stay, segment: segment, updateBlock: updateBlock)
        updateBlock(identifier, plugin, nil)
    }
    
}

enum CheckInPlugin: PluginTile {
    case checkIn(stay: TilePluginStay, segment: TilePluginSegment, updateBlock: TilePluginUpdateBlock)
    
    var accessibilityId: String { return "UIA_CheckInTile" }
    
    var title: String? { return "Check In" }
    
    var icon: UIImage? { return UIImage(named:"fullcard_checkinAvail") }
    
    var routableDeeplinks: [String] { return ["checkIn"] }
    
    func performAction(sender: UIViewController?) {
        
        switch self {
        case .checkIn(let stay, let segment, let updateBlock):
            
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
