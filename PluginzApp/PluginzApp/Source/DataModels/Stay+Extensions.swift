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
    public var keyStatus: DKeyStatus {
        get {
            guard let status = DKeyStatus.init(rawValue: keyStatusString) else {
                return .notSupported
            }
            return status
        }
        set(newValue) {
            keyStatusString = newValue.rawValue
        }
    }
    
}
