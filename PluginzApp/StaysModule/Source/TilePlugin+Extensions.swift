//
//  TilePlugin+Extensions.swift
//  StaysModule
//
//  Created by Jianhao Song on 4/3/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

extension TilePlugin {
    
    // Sort order for all plugin factories
    // TODO: this should move to the APP layer, but be accessible via some protocol...
    fileprivate var priority: [String] {
        return ["DKEY_PRIMARY", "DKEY_SECONDARY", "CHECK_IN", "HOTEL_IMAGES"]
    }
    
    var order: Int {
        return priority.index(where: { identifier.hasPrefix($0) }) ?? -1
    }
 
}

extension Array where Iterator.Element == TilePlugin {
    
    // Wideness is an array of Bools indicating for each tile if the VC should lay out the tile in single or double width
    func wideness() -> [Bool] {
        let cellsPerRow = 2
        var total = 0
        var newWideness: [Bool] = []
        
        for i in 0..<count {
            let pos = total % (cellsPerRow > 0 ? cellsPerRow : 2)
            if self[i].isWide == nil {
                newWideness.append(pos + 2 <= cellsPerRow)
            } else {
                newWideness.append(self[i].isWide ?? false)
            }
            let width = newWideness[i] ? 2 : 1
            total += width
        }
        
        return newWideness
    }
    
}
