//
//  AppDelegate+Extensions.swift
//  PluginzApp
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary
import StaysModule
import CheckInModule
import DKModule

extension AppDelegate: StaysModuleDelegate {
    
    fileprivate var priority: [String] { return ["DKEY_PRIMARY", "DKEY_SECONDARY", "CHECK_IN", "HOTEL_IMAGES"] }
    
    // Register all the modules that can provide tile plugins
    var tilePluginModules: [TilePluginModule.Type] { return [CheckInModule.self, DKeyModule.self, StaysModule.self] }
    
    func registerPlugins(forStay stay: Stay, updateBlock: @escaping TilePluginUpdateBlock) {
        tilePluginModules.forEach { module in
            module.tilePluginFactories.forEach { factory in
                factory.order = priority.index(where: { factory.identifier.hasPrefix($0) }) ?? -1
                factory.registerPlugin(forStay: stay, updateBlock: updateBlock)
            }
        }
    }
    
}

extension AppDelegate: CheckInModuleDelegate {
    
    func checkInCompleted(stay: TilePluginStay, segment: TilePluginSegment, updateBlock: @escaping TilePluginUpdateBlock) {
        // Check in complete, so update our data
        if var segment = segment as? CheckInSegment {
            segment.checkInAvailable = false
        }
        // And tell the CheckInModule to refresh its tile plugins for this stay
        CheckInModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
        
        // Update the stay key status to make it available for requesting a key (if DKey is supported)
        if let stay = stay as? DKeyStay, var dkeySegment = segment as? DKeySegment, stay.dKeySupported {
            dkeySegment.keyStatus = .requestKey
        }
        // And tell the DKeyModule to refresh its tile plugins for this stay
        DKeyModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }

}

extension AppDelegate: DKeyModuleDelegate {
    
    func keyRequested(stay: DKeyStay, segment: DKeySegment, updateBlock: @escaping TilePluginUpdateBlock) {
        
        // Update the stay key status to reflect that the key has been requested
        var dkeySegment = segment
        dkeySegment.keyStatus = .requested
        
        // And tell the DKeyModule to refresh its tile plugins for this stay
        DKeyModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }
    
    func keyDelivered(stay: DKeyStay, segment: DKeySegment, updateBlock: @escaping TilePluginUpdateBlock) {
        
        // Update the stay key status to reflect that the key has been requested
        var dkeySegment = segment
        dkeySegment.keyStatus = .delivered
        
        // And tell the DKeyModule to refresh its tile plugins for this stay
        DKeyModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }
    
}
