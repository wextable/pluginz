//
//  DKeyLiveKeyViewController.swift
//  DKModule
//
//  Created by Wesley St. John on 4/3/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation

class DKeyLiveKeyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 60, width: 300, height: 50)
        label.text = "You can unlock your room now!"
        view.addSubview(label)
        
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 120, width: 120, height: 40)
        button.setTitle("Unlock Room 418", for: .normal)
        button.addTarget(self, action: #selector(unlockTapped), for: .touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 20, y: 200, width: 120, height: 40)
        button2.setTitle("Done", for: .normal)
        button2.addTarget(self, action: #selector(dismiss(animated:completion:)), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    
    @objc func unlockTapped() {
        let alert = UIAlertController(title: "Door Unlocked!", message: "You did it, buddy!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
//    @objc func dismiss() {
//        dismiss(animated: true)
//    }
    
    
    
}
