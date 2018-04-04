//
//  Stay.swift
//  PluginzApp
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import StaysModule
import CheckInModule
import DKModule


extension Stay: CheckInStay, DKeyStay {

    public var keyStatuses: [DKeyStatus] {
        get {
            return keyStatusStrings.flatMap {
                DKeyStatus.init(rawValue: $0)
            }
        }
        set(newValue) {
            keyStatusStrings = newValue.map {
                $0.rawValue
            }
        }
    }
    
}
