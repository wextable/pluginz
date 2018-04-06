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
    public var hotelImageName: String = ""
    
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

public class StaysModule: TilePluginModule {
    // Even though the StaysModule framework (StayCardViewModel/Controller specifically) will consume TilePlugins, the StaysModule also provides plugins
    public static var tilePluginFactories: [TilePluginFactory.Type] = [HotelImagesPluginFactory.self]
    
    public static var delegate: StaysModuleDelegate?
    
    static func registerPlugins(forStay stay: Stay, updateBlock: @escaping TilePluginUpdateBlock) {
        delegate?.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }
}

public protocol StaysModuleDelegate {
    // This will register all relevant plugins app-wide for this stay
    func registerPlugins(forStay stay: Stay, updateBlock: @escaping TilePluginUpdateBlock)
}
