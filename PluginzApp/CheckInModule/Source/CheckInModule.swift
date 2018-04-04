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


final public class CheckInModule<T>: TilePluginModule where T: CheckInStay {
    
    let tilePluginFactories = [CheckInPluginFactory<T>.self]
    
    public init() {}
    
    public func registerPlugins(forStay stay: T, updateBlock: @escaping TilePluginUpdateBlock) {
        tilePluginFactories.forEach { $0.registerPlugin(forStay: stay, module: self, updateBlock: updateBlock) }
    }
    
    public var delegate: CheckInModuleDelegate?
    
    public func checkInCompleted(stay: CheckInStay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.checkInCompleted(stay: stay, updateBlock: updateBlock)
    }
    
}

public protocol CheckInModuleDelegate {
    func checkInCompleted(stay: CheckInStay, updateBlock: @escaping TilePluginUpdateBlock)
}
