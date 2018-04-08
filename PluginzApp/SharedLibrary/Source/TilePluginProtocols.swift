//
//  TilePluginProtocols.swift
//  SharedLibrary
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

public protocol TilePluginStay {
    
    var ctyhocn:            String  { get }
    var confirmationNumber: String  { get }
    
    var segments:           [TilePluginSegment]     { get set }
}

public protocol TilePluginSegment {
    
    var segmentNumber: String  { get }
}

public typealias TilePluginUpdateBlock = (_ identifier: String, _ Plugin: PluginTile?, _ completion: TilePluginUpdateBlockCompletion?) -> Void
/// hostViewController is the view controller hosts the plugin which will be the full card view controller in StaysModule
public typealias TilePluginUpdateBlockCompletion = (_ hostViewController: UIViewController?) -> Void


public protocol TilePlugin {
    
    /// This is coming from global prefs and should be unique per plugin
    static var identifier: String   { get }
    
    static func fetchTile(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock)
}


public protocol PluginTile  {
    
    var accessibilityId:    String      { get }
    var title:              String?     { get }
    var titleColor:         UIColor?    { get }
    var icon:               UIImage?    { get }
    var iconTintColor:      UIColor?    { get }
    var backgroundImage:    UIImage?    { get }
    var view:               UIView?     { get }
    var isWide:             Bool?       { get }
    var routableDeeplinks:  [String]    { get }
    
    func performAction(sender: UIViewController?)
    func performDeepLinkAction(deeplink: String, sender: UIViewController?)
    
}


public extension PluginTile {
    var title:              String?     { return nil }
    var titleColor:         UIColor?    { return .black }
    var icon:               UIImage?    { return nil }
    var iconTintColor:      UIColor?    { return .blue }
    var backgroundImage:    UIImage?    { return nil } 
    var view:               UIView?     { return nil }
    var isWide:             Bool?       { return false }
    var routableDeeplinks:  [String]    { return [] }
    
    func performDeepLinkAction(deeplink: String, sender: UIViewController?) {
        performAction(sender: sender)
    }
    
}


public protocol TilePluginModule {
    
    static var tilePlugins: [TilePlugin.Type] { get }
    
}
public extension TilePluginModule {
    
    static func fetchTiles(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        tilePlugins.forEach { $0.fetchTile(forStay: stay, updateBlock: updateBlock) }
    }
    
}
