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

public class DKeyModule: TilePluginModule {
    public static var tilePluginFactories: [TilePluginFactory.Type] = [DKeyPrimaryPluginFactory.self]
    
    public static var delegate: DKeyModuleDelegate?
    
    public static func keyRequested(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.keyRequested(stay: stay, updateBlock: updateBlock)
    }

    public static func keyDelivered(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.keyDelivered(stay: stay, updateBlock: updateBlock)
    }
}

public protocol DKeyModuleDelegate {
    func keyRequested(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock)
    func keyDelivered(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock)
}
