//
//  FullCardTile.swift
//  StaysModule
//
//  Created by Jianhao Song on 4/3/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

struct FullCardTile {
    
    fileprivate let pluginTile: PluginTile
    let identifier: String
    var isWideTile: Bool = false
    var order: Int { return StaysModule.tileOrder(forIdentifier: identifier) ?? -1 }
    
    init(pluginTile: PluginTile, identifier: String) {
        self.pluginTile = pluginTile
        self.identifier = identifier
    }
    
}


extension FullCardTile: PluginTile {
    
    var accessibilityId:    String              { return pluginTile.accessibilityId }
    var title:              String?             { return pluginTile.title }
    var titleColor:         UIColor?            { return pluginTile.titleColor }
    var icon:               UIImage?            { return pluginTile.icon }
    var iconTintColor:      UIColor?            { return pluginTile.iconTintColor }
    var backgroundImage:    UIImage?            { return pluginTile.backgroundImage }
    var view:               UIView?             { return pluginTile.view }
    var isWide:             Bool?               { return pluginTile.isWide }
    var routableDeeplinks:  [String]            { return pluginTile.routableDeeplinks }
    
    func performAction(sender: UIViewController?) {
        pluginTile.performAction(sender: sender)
    }
    
    func performDeepLinkAction(deeplink: String, sender: UIViewController?) {
        pluginTile.performDeepLinkAction(deeplink: deeplink, sender: sender)
    }
}


extension Array where Iterator.Element == FullCardTile {
    
    mutating func layout() {
        var total = 0
        let cellsPerRow = 2
        
        // foreach doesn't work here because $0 is a struct
        for i in 0..<count {
            let pos = total % cellsPerRow
            // isWide return nil means it is a flexible tile so we need to calculate the size on the fly
            if let isWide = self[i].pluginTile.isWide {
                self[i].isWideTile = isWide
            } else {
                self[i].isWideTile = pos + 2 <= cellsPerRow
            }
            let width = self[i].isWideTile ? 2 : 1
            total += width
        }
    }
    
}
