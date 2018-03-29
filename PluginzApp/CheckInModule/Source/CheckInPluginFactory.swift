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
        
        guard let checkInStay = stay as? CheckInStay else {
            updateBlock(identifier, nil, nil)
            return
        }
        
//        if checkInStay.checkInAvailable
        
    }
    
    
    
}

enum CheckInPlugin: TilePlugin {
    case checkIn(stay: CheckInStay, identifier: String)
    
    var identifier: String {
        switch self {
        case .checkIn(_, let identifier):
            return identifier
        }
    }
    
    var accessibilityId: String { return "UIA_CheckInTile" }
    
    var title: String? { return "Check In" }
    
    var icon: UIImage? { return nil }
    
    func performAction(sender: UIViewController?) {
        
    }
    
    
    
}
