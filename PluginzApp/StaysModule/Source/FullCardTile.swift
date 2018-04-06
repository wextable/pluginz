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
    
    let plugin: TilePlugin
    let identifier: String
    var isWide: Bool = false
    
    init(plugin: TilePlugin, identifier: String) {
        self.plugin = plugin
        self.identifier = identifier
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
            if let isWide = self[i].plugin .isWide {
                self[i].isWide = isWide
            } else {
                self[i].isWide = pos + 2 <= cellsPerRow
            }
            let width = self[i].isWide ? 2 : 1
            total += width
        }
    }
    
}
