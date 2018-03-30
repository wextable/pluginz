//
//  CheckInModule.swift
//  CheckInModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary


public protocol CheckInStay: TilePluginStay {
    var checkInAvailable: Bool { get set }
}


public class CheckInModule: TilePluginModule {
    public static var tilePluginFactories: [TilePluginFactory.Type] = []
    
    public static var delegate: CheckInModuleDelegate?
    
    public static func checkInCompleted(stay: CheckInStay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.checkInCompleted(stay: stay, updateBlock: updateBlock)
    }
    
}

public protocol CheckInModuleDelegate {
    func checkInCompleted(stay: CheckInStay, updateBlock: @escaping TilePluginUpdateBlock)
}
