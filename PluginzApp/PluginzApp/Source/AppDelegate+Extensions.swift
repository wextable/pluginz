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
    
    func registerPlugins(forStay stay: Stay, updateBlock: @escaping TilePluginUpdateBlock) {
        checkInModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
        dkeyModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }
    
}

extension AppDelegate: CheckInModuleDelegate {
    
    func checkInCompleted(stay: CheckInStay, updateBlock: @escaping TilePluginUpdateBlock) {
        guard let stay = stay as? Stay else { return }
        
        checkInModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
        stay.keyStatus = .requestKey
        dkeyModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }

}

extension AppDelegate: DKeyModuleDelegate {
    
    func keyRequested(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        guard let stay = stay as? Stay else { return }
        
        stay.keyStatus = .requested
        dkeyModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }
    
    func keyDelivered(stay: DKeyStay, updateBlock: @escaping TilePluginUpdateBlock) {
        guard let stay = stay as? Stay else { return }
        
        stay.keyStatus = .liveKey
        dkeyModule.registerPlugins(forStay: stay, updateBlock: updateBlock)
    }
    
}
