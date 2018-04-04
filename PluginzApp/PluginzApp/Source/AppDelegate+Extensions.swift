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
    
    func checkInCompleted(stay: CheckInStay, updateBlock: @escaping TilePluginUpdateBlock) {
        CheckInModule.registerPlugin(forStay: stay, updateBlock: updateBlock)
        
        guard var dkeyStay = stay as? DKeyStay,
            dkeyStay.dKeySupported else { return }
        dkeyStay.keyStatus = .requestKey
        DKeyModule.registerPlugin(forStay: dkeyStay, updateBlock: updateBlock)
    }

}

extension AppDelegate: DKeyModuleDelegate {
    
    func keyRequested(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        var dkeyStay = stay
        dkeyStay.keyStatus = .requested
        DKeyModule.registerPlugin(forStay: dkeyStay, updateBlock: updateBlock)
    }
    
    func keyDelivered(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        var dkeyStay = stay
        dkeyStay.hasKey = true
        DKeyModule.registerPlugin(forStay: dkeyStay, updateBlock: updateBlock)
    }
    
}
