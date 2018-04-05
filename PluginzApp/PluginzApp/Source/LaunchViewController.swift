//
//  LaunchViewController.swift
//  PluginzApp
//
//  Created by Wesley St. John on 4/3/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import UIKit
import SharedLibrary
import StaysModule
import CheckInModule
import DKModule

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let stayCardVC = segue.destination as? StayCardViewController,
            let button = sender as? UIButton else { return }
        
        if button.title(for: .normal) == "Stay 1" {
        
            let stay = Stay()
            stay.confirmationNumber = "12345678"
            stay.ctyhocn = "DCAOTHF"
            stay.dKeySupported = true
            stay.hotelImageName = "hotel"
            
            let primarySegment = Segment()
            primarySegment.checkInAvailable = true
            primarySegment.keyStatusString = "learnMore"
            primarySegment.segmentNumber = "1"
            
            let secondarySegment = Segment()
            secondarySegment.checkInAvailable = true
            secondarySegment.keyStatusString = "learnMore"
            secondarySegment.segmentNumber = "2"
            
            stay.segments = [primarySegment, secondarySegment]
            
            let viewModel = StayCardViewModel(stay: stay)
            stayCardVC.viewModel = viewModel
            
        } else {
            let stay = Stay()
            stay.confirmationNumber = "87654321"
            stay.ctyhocn = "DCAOTHF"
            stay.dKeySupported = true
            stay.hotelImageName = "hotel"
            
            let primarySegment = Segment()
            primarySegment.checkInAvailable = false
            primarySegment.keyStatusString = "delivered"
            primarySegment.segmentNumber = "1"
            
            stay.segments = [primarySegment]
            
            let viewModel = StayCardViewModel(stay: stay)
            stayCardVC.viewModel = viewModel
            stayCardVC.deeplink = "key"
        }
        
        
    }

}
