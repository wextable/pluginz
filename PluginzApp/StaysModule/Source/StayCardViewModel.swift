//
//  StayCardViewModel.swift
//  StaysModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation

public class StayCardViewModel {
    var stay: Stay?
    
    init(stay: Stay) {
        self.stay = stay
        
        StaysModule.registerPlugins(forStay: stay) { identifier, plugin, completion in
            
            // update data source
            // refresh/reload collection view
            
        }
    }
    
}
