//
//  StayCardViewController.swift
//  StaysModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import UIKit

class StayCardCell: UICollectionViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
}

public class StayCardViewController: UICollectionViewController {

    public var viewModel: StayCardViewModel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "StayCardCell", for: indexPath)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? StayCardCell else { return }
    }
    
}
