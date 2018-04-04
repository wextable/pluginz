//
//  DKeyLiveKeyViewController.swift
//  DKModule
//
//  Created by Wesley St. John on 4/3/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation

class DKeyLiveKeyViewController: UIViewController {

    var roomNames: [String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 198.0/255.0, green: 229.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 60, width: 500, height: 50)
        let text = "You can unlock \(roomNames.map{ "room " + $0 }.joined(separator: ", "))"
        label.text = text
        view.addSubview(label)
        
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 120, width: 200, height: 40)
        button.setTitle("Unlock Nearest Room", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(self, action: #selector(unlockTapped), for: .touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 20, y: 200, width: 120, height: 40)
        button2.setTitle("Done", for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button2.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        view.addSubview(button2)
        
    }
    
    
    @objc func unlockTapped() {
        let alert = UIAlertController(title: "Door Unlocked!", message: "You did it, buddy!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func doneTapped() {
        dismiss(animated: true)
    }
    
}
