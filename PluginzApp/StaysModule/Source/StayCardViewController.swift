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
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
}

public class StayCardViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    public var viewModel: StayCardViewModel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.registerPlugins()
    }
    
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tiles.count
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "StayCardCell", for: indexPath)
    }
    
    override public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? StayCardCell else { return }
        
        let tile = viewModel.tiles[indexPath.item]
        cell.titleLabel.text = tile.title
        cell.iconImageView.image = tile.icon
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
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
