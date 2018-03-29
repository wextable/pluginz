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
    public var confirmationNumber: String?
    
    public var checkInAvailable: Bool = false
    public var keyStatusString: String = ""
}

public class StaysModule: TilePluginModule {
    public static var tilePluginFactories: [TilePluginFactory.Type] = []
    
    
}

public protocol StaysModuleDelegate {
    func registerPlugins(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock)
}
