//
//  StaysPlugin.swift
//  StaysModule
//
//  Created by Wesley St. John on 4/4/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

import Foundation
import SharedLibrary

struct HotelImagesPluginFactory: TilePluginFactory {
    static var identifier: String { return "HOTEL_IMAGES" }
    
    static func registerPlugin(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        // The only TilePlugin we deal with here is the hotel images plugin, and it applies to every stay, so we are ready to create it
        let plugin = StaysPlugin.images(stay: stay, identifier: identifier, updateBlock: updateBlock)
        
        // Call the update block to update the UI
        updateBlock(identifier, plugin, nil)
    }
    
}

enum StaysPlugin: TilePlugin {
    // only 1 case for StaysPlugin
    case images(stay: TilePluginStay, identifier: String, updateBlock: TilePluginUpdateBlock)
    
    var identifier: String {
        switch self {
        case .images(_, let identifier, _):
            return identifier
        }
    }
    
    var title: String? { return "Hotel Images" }
    
    var accessibilityId: String { return "UIA_HotelImages" }
    
    var backgroundImage: UIImage? {
        switch self {
        case .images(let stay, _, _):
            if let stay = stay as? Stay {
                return UIImage(named: stay.hotelImageName)
            }
        }
        return nil
    }
    
    var isWide: Bool? { return nil }
    
    func performAction(sender: UIViewController?) {
        
        switch self {
        case .images(let stay, _, _):
            // Launch a VC with a full screen image of the hotel
            guard let vc = sender,
                let stay = stay as? Stay else { return }
            let imageVC = ImageViewController()
            imageVC.imageName = stay.hotelImageName
            vc.present(imageVC, animated: true, completion: nil)
        }
        
    }
    
}
