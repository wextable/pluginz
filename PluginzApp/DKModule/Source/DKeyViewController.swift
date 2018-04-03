//
//  DKeyViewController.swift
//  DKeyModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import UIKit

class DKeyViewController: UIViewController {
    
    var completion: (() -> Void)?
    var text = ""
    var buttonText = "OK"

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.frame = CGRect(x: 20, y: 60, width: 300, height: 50)
        label.text = text
        view.addSubview(label)
        
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 120, width: 120, height: 40)
        button.setTitle(buttonText, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        
    }


    @objc func buttonTapped() {
        
        completed()
    }
    
    func completed() {
        
        dismiss(animated: true) {
            self.completion?()
        }
    }
    
    

}
