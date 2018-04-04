//
//  StaysModule.swift
//  StaysModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

public class Stay: TilePluginStay {
    public var ctyhocn: String = ""
    public var confirmationNumber: String = ""
    
    public var dKeySupported: Bool = false
    public var hasKey: Bool = false
    
    public var segments: [TilePluginSegment] = []
    
    public init() {}
}

public class Segment: TilePluginSegment {
    public var segmentNumber: String = ""
    public var checkInAvailable: Bool = false
    public var keyStatusString: String = ""
    
    public init() {}
}

public class StaysModule {
    
    public static var delegate: StaysModuleDelegate?
    
    static func registerPlugins(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }
}

public protocol StaysModuleDelegate {
    func registerPlugins(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock)
}
