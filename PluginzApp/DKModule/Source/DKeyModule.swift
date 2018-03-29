//
//  DKeyModule.swift
//  DKeyModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

public enum DKeyStatus {
    case notSupported
    case learnMore
    case canRequest
    case requested
    case liveKey
}

public protocol DKeyStay: TilePluginStay {
    var keyStatus: DKeyStatus { get }
}

public class DKeyModule: TilePluginModule {
    public static var tilePluginFactories: [TilePluginFactory.Type] = []
    
    
}
