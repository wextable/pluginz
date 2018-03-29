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
        if keyStatusString == "" { return .learnMore }
        else if keyStatusString == "" { return .canRequest }
        else if keyStatusString == "" { return .requested }
        else if keyStatusString == "" { return .liveKey }
        else { return .notSupported }
    }
    
}
