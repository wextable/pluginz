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
    
    func didUpdateTiles(updater: CollectionViewUpdater?, newTiles: [TilePlugin])
}


public class StayCardViewModel {
    var stay: Stay
    var shouldAnimateCells = false
    weak var delegate: HHStayCardViewModelDelegate?
    var tempTiles: [TilePlugin] = []
    var tiles: [TilePlugin] = []
    var wideness: [Bool] = []
    
    public init(stay: Stay) {
        self.stay = stay
    }
    
    func registerPlugins() {
        // Disable batch update when we call registerPlugins
        shouldAnimateCells = false
        
        StaysModule.registerPlugins(forStay: stay) { [weak self] (identifier, plugin, completion) in
            
            // The update block is the same for every plugin
            // We update our data source and refresh the UI
            self?.updateTiles(identifier, plugin: plugin)
            
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
    
    func updateTiles(_ identifier: String?, plugin: TilePlugin?) {
        guard let delegate = delegate else { return }
        
        var deletedIndices: [IndexPath] = []
        var insertedIndices: [IndexPath] = []
        var updatedIndices: [IndexPath] = []
        
        if let plugin = plugin {
            if let index = tempTiles.index(where: { $0.identifier == identifier }) {
                tempTiles[index] = plugin
                updatedIndices = [IndexPath(item: index, section: 0)]
                
            } else {
                var index = tempTiles.count
                for i in 0..<tempTiles.count where plugin.order < tempTiles[i].order {
                    index = i
                    break
                }
                insertedIndices = [IndexPath(item: index, section: 0)]
                tempTiles.insert(plugin, at: index)
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
        wideness = tiles.wideness()
        delegate?.didUpdateTiles(updater: nil, newTiles: [])
    }
    
    func updateDataSource(newTiles: [TilePlugin]) {
        tiles = newTiles
        wideness = tiles.wideness()
    }
    
}
