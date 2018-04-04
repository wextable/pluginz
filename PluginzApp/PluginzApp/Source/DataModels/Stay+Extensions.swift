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


extension Stay: DKeyStay {}

extension Segment: CheckInSegment, DKeySegment {
    
    public var keyStatus: DKeyStatus? {
        get {
            guard let status = DKeyStatus.init(rawValue: keyStatusString) else {
                return nil
            }
            return status
        }
        set(newValue) {
            if let value = newValue?.rawValue {
                keyStatusString = value
            }
        }
    }
    
}
