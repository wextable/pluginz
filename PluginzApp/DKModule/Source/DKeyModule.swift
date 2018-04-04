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
    case learnMore
    case requestKey
    case requested
    case delivered
}

public protocol DKeyStay: TilePluginStay {
    var dKeySupported: Bool         { get set }
}

extension DKeyStay {
    var hasKey: Bool {
        return (segments as? [DKeySegment])?.contains(where: { $0.keyStatus == .delivered }) ?? false
    }
    
}

public protocol DKeySegment:TilePluginSegment {
    var keyStatus: DKeyStatus?   { get set }
}

public class DKeyModule: TilePluginModule {
    public static var tilePluginFactories: [TilePluginFactory.Type] = [DKeyPrimaryPluginFactory.self, DKeySecondaryPluginFactory.self]
    
    public static var delegate: DKeyModuleDelegate?
    
    public static func keyRequested(stay: DKeyStay, segment: DKeySegment, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.keyRequested(stay: stay, segment: segment, updateBlock: updateBlock)
    }

    public static func keyDelivered(stay: DKeyStay, segment: DKeySegment, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.keyDelivered(stay: stay, segment: segment, updateBlock: updateBlock)
    }
}

public protocol DKeyModuleDelegate {
    func keyRequested(stay: DKeyStay, segment: DKeySegment, updateBlock: @escaping TilePluginUpdateBlock)
    func keyDelivered(stay: DKeyStay, segment: DKeySegment, updateBlock: @escaping TilePluginUpdateBlock)
}
