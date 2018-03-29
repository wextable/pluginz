//
//  CheckInViewController.swift
//  CheckInModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {
    
    var completion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.frame = CGRect(x: 20, y: 60, width: 300, height: 50)
        label.text = "You can check in to the hotel now!"
        view.addSubview(label)
        
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 120, width: 120, height: 40)
        button.setTitle("Check In", for: .normal)
        button.addTarget(self, action: #selector(checkInTapped), for: .touchUpInside)
        view.addSubview(button)
        
    }


    @objc func checkInTapped() {
        
        checkInCompleted()
    }
    
    func checkInCompleted() {
        
        dismiss(animated: true) {
            self.completion?()
        }
    }
    
    

}
