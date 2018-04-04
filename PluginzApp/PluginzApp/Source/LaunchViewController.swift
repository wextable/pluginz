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
        
        guard let stayCardVC = segue.destination as? StayCardViewController else { return }
        
        let stay = Stay()
        stay.confirmationNumber = "12345678"
        stay.ctyhocn = "DCAOTHF"
        stay.dKeySupported = true
        
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
    }

}
