//
//  ImageViewController.swift
//  StaysModule
//
//  Created by Wesley St. John on 4/4/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var imageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray

        // Do any additional setup after loading the view.
        let imageView = UIImageView()
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 40, width: 100, height: 30)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
