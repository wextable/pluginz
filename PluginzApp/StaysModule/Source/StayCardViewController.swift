//
//  StayCardViewController.swift
//  StaysModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import UIKit
import SharedLibrary

class StayCardCell: UICollectionViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
}

public class StayCardViewController: UICollectionViewController {

    public var viewModel: StayCardViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.registerPlugins()
    }
    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tiles.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "StayCardCell", for: indexPath)
    }
    
    public override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? StayCardCell else { return }
        
        let tile = viewModel.tiles[indexPath.item]
        cell.titleLabel.text = tile.title
        cell.backgroundImageView.image = tile.backgroundImage
        cell.iconImageView.image = tile.icon
        cell.iconImageView.tintColor = tile.iconTintColor
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tile = viewModel.tiles[indexPath.item]
        tile.performAction(sender: self)
    }

}


extension StayCardViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 130)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    
}


extension StayCardViewController: HHStayCardViewModelDelegate {
    
    func didUpdateTiles(updater: CollectionViewUpdater?, newTiles: [TilePlugin]) {
        DispatchQueue.main.async {
            if let updater = updater {
                self.collectionView?.performBatchUpdates({
                    
                    self.collectionView?.insertItems(at: updater.inserted)
                    self.collectionView?.deleteItems(at: updater.deleted)
                    self.collectionView?.reloadItems(at: updater.updated)
                    
                    self.viewModel.updateDataSource(newTiles: newTiles)
                    
                }, completion: nil)
                
            } else {
                self.collectionView?.collectionViewLayout.invalidateLayout()
                self.collectionView?.reloadData()
            }
        }
    }
    
}
