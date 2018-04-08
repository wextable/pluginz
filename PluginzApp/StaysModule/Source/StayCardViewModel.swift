//
//  StayCardViewModel.swift
//  StaysModule
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

/// Provide data for collection view batch update
struct CollectionViewUpdater {
    
    var inserted: [IndexPath]
    var deleted: [IndexPath]
    var updated: [IndexPath]
    
    init(inserted: [IndexPath] = [], deleted: [IndexPath] = [], updated: [IndexPath] = []) {
        self.inserted = inserted
        self.deleted = deleted
        self.updated = updated
    }
    
}


protocol HHStayCardViewModelDelegate: class {
    
    func didUpdateTiles(updater: CollectionViewUpdater?, newTiles: [FullCardTile])
}


public class StayCardViewModel {
    var stay: Stay
    var shouldAnimateCells = false
    weak var delegate: HHStayCardViewModelDelegate?
    var tempTiles: [FullCardTile] = []
    var tiles: [FullCardTile] = []
    
    public init(stay: Stay) {
        self.stay = stay
    }
    
    func fetchTiles() {
        // Disable batch update when we call fetchTiles
        shouldAnimateCells = false
        
        StaysModule.fetchTiles(forStay: stay) { [weak self] (identifier, pluginTile, completion) in
            
            // The update block is the same for every plugin
            // We update our data source and refresh the UI
            self?.updateTiles(identifier, pluginTile: pluginTile)
            
            // And call completion
            if let viewController = self?.delegate as? UIViewController {
                completion?(viewController)
            }
        }
        
        // For API calls that has been cached by AFNetworking because those are still considered as async calls
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) { [weak self] in
            // Reload entire collection view
            self?.layoutTiles()
            // Re-enable batch update
            self?.shouldAnimateCells = true
        }
    }
    
    func updateTiles(_ identifier: String, pluginTile: PluginTile?) {
        guard let delegate = delegate else { return }
        
        var deletedIndices: [IndexPath] = []
        var insertedIndices: [IndexPath] = []
        var updatedIndices: [IndexPath] = []
        
        if let pluginTile = pluginTile {
            let tile = FullCardTile.init(pluginTile: pluginTile, identifier: identifier)
            if let index = tempTiles.index(where: { $0.identifier == identifier }) {
                tempTiles[index] = tile
                updatedIndices = [IndexPath(item: index, section: 0)]
                
            } else {
                var index = tempTiles.count
                for i in 0..<tempTiles.count where tile.order < tempTiles[i].order {
                    index = i
                    break
                }
                insertedIndices = [IndexPath(item: index, section: 0)]
                tempTiles.insert(tile, at: index)
            }
            
        } else if let index = tiles.index(where: { $0.identifier == identifier }) {
            deletedIndices = [IndexPath(item: index, section: 0)]
            tempTiles.remove(at: index)
        }
        
        if shouldAnimateCells {
            let updater = CollectionViewUpdater(inserted: insertedIndices, deleted: deletedIndices, updated: updatedIndices)
            let newTiles = tempTiles
            delegate.didUpdateTiles(updater: updater, newTiles: newTiles)
        }
    }
    
    public func layoutTiles() {
        tiles = tempTiles
        tiles.layout()
        delegate?.didUpdateTiles(updater: nil, newTiles: [])
    }
    
    func updateDataSource(newTiles: [FullCardTile]) {
        tiles = newTiles
        tiles.layout()
    }
    
}
