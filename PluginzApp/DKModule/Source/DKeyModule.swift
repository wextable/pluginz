//
//  DKeyModule.swift
//  DKeyModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

public enum DKeyStatus: String {
    case notSupported
    case learnMore
    case requestKey
    case requested
    case liveKey
}

public protocol DKeyStay: TilePluginStay {
    var keyStatus: DKeyStatus { get set }
}

public class DKeyModule<T>: TilePluginModule where T: DKeyStay {
    
    let tilePluginFactories = [DKeyPrimaryPluginFactory<T>.self]
    
    public init() {}
    
    public func registerPlugins(forStay stay: T, updateBlock: @escaping TilePluginUpdateBlock) {
        tilePluginFactories.forEach { $0.registerPlugin(forStay: stay, module: self, updateBlock: updateBlock) }
    }
    
    public typealias PluginStay = T
    
    public var delegate: DKeyModuleDelegate?
    
    public func keyRequested(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.keyRequested(stay: stay, updateBlock: updateBlock)
    }

    public func keyDelivered(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.keyDelivered(stay: stay, updateBlock: updateBlock)
    }
}

public protocol DKeyModuleDelegate {
    func keyRequested(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock)
    func keyDelivered(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock)
}
