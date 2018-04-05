//
//  CheckInModule.swift
//  CheckInModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

public protocol CheckInSegment: TilePluginSegment {
    var checkInAvailable: Bool { get set }
}


public class CheckInModule: TilePluginModule {
    // Check in Module provides one type of TilePluginFactory
    public static var tilePluginFactories: [TilePluginFactory.Type] = [CheckInPluginFactory.self]
    
    public static var delegate: CheckInModuleDelegate?
    
    public static func checkInCompleted(stay: TilePluginStay, segment: TilePluginSegment, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.checkInCompleted(stay: stay, segment: segment, updateBlock: updateBlock)
    }
    
}

public protocol CheckInModuleDelegate {
    func checkInCompleted(stay: TilePluginStay, segment: TilePluginSegment, updateBlock: @escaping TilePluginUpdateBlock)
}
