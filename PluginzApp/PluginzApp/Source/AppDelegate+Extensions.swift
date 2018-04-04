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
    
    var tilePluginModules: [TilePluginModule.Type] { return [CheckInModule.self, DKeyModule.self] }
    
    func registerPlugins(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        tilePluginModules.forEach {
            $0.registerPlugin(forStay: stay, updateBlock: updateBlock)
        }
    }
    
}

extension AppDelegate: CheckInModuleDelegate {
    
    func checkInCompleted(stay: TilePluginStay, segment: TilePluginSegment, updateBlock: @escaping TilePluginUpdateBlock) {
        if var segment = segment as? CheckInSegment {
            segment.checkInAvailable = false
        }
        CheckInModule.registerPlugin(forStay: stay, updateBlock: updateBlock)
        
        if let stay = stay as? DKeyStay, var dkeySegment = segment as? DKeySegment, stay.dKeySupported {
            dkeySegment.keyStatus = .requestKey
        }
        DKeyModule.registerPlugin(forStay: stay, updateBlock: updateBlock)
    }

}

extension AppDelegate: DKeyModuleDelegate {
    
    func keyRequested(stay: DKeyStay, segment: DKeySegment, updateBlock: @escaping TilePluginUpdateBlock) {
        guard stay.dKeySupported else { return }
        
        var dkeySegment = segment
        dkeySegment.keyStatus = .requested
        DKeyModule.registerPlugin(forStay: stay, updateBlock: updateBlock)
    }
    
    func keyDelivered(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        var dkeyStay = stay
        dkeyStay.hasKey = true
        DKeyModule.registerPlugin(forStay: dkeyStay, updateBlock: updateBlock)
    }
    
}
