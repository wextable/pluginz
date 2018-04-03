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
    
    fileprivate var priority: [String] {
        return ["DKEY_PRIMARY", "CHECK_IN"]
    }
    
    var order: Int {
        return priority.index(where: { identifier.hasPrefix($0) }) ?? -1
    }
    
}
