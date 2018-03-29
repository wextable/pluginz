//
//  TilePluginProtocols.swift
//  SharedLibrary
//
//  Created by Wesley St. John on 3/29/18.
//  Copyright © 2018 mobileforming. All rights reserved.
//

public protocol TilePluginStay {
    
    var ctyhocn:            String  { get }
    var confirmationNumber: String? { get }
    
}

public typealias TilePluginUpdateBlock = (_ identifier: String?, _ Plugin: TilePlugin?, _ completion: TilePluginUpdateBlockCompletion?) -> Void
/// hostViewController is the view controller hosts the plugin which will be the full card view controller in StaysModule
public typealias TilePluginUpdateBlockCompletion = (_ hostViewController: UIViewController?) -> Void


public protocol TilePluginFactory {
    
    /// This is coming from global prefs and should be unique per plugin
    static var identifier: String { get }
    
    static func registerPlugin(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock)
}


public protocol TilePlugin  {
    
    /// This is coming from global prefs and should be unique per plugin
    var identifier:         String { get }
    var accessibilityId:    String      { get }
    var title:              String?     { get }
    var titleColor:         UIColor?    { get }
    var subtitle:           String?     { get }
    var subtitleColor:      UIColor?    { get }
    var icon:               UIImage?    { get }
    var iconTintColor:      UIColor?    { get }
    var backgroundImage:    UIImage?    { get }
    var view:               UIView?     { get }
    var isWide:             Bool?       { get }
    var isFlexible:         Bool        { get }
    var supportedWildcards: [String]    { get }
    
    func performAction(sender: UIViewController?)
    func performDeepLinkAction(sender: UIViewController?)
    
}


public extension TilePlugin {
    
    var titleColor:         UIColor?    { return .black }
    var subtitle:           String?     { return nil }
    var subtitleColor:      UIColor?    { return .blue }
    var iconTintColor:      UIColor?    { return .blue }
    var backgroundImage:    UIImage?    { return nil } 
    var view:               UIView?     { return nil }
    var isWide:             Bool?       { return false }
    var isFlexible:         Bool        { return false }
    var supportedWildcards: [String]    { return [] }
    
    func performDeepLinkAction(sender: UIViewController?) {
        performAction(sender: sender)
    }
    
}


public protocol TilePluginModule {
    
    static var tilePluginFactories: [TilePluginFactory.Type] { get }
    
}


public extension TilePluginModule {
    
    static func registerPlugin(forStay stay: TilePluginStay, updateBlock: @escaping TilePluginUpdateBlock) {
        tilePluginFactories.forEach { $0.registerPlugin(forStay: stay, updateBlock: updateBlock) }
    }
    
}
