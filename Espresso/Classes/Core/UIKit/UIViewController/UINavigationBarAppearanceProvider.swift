//
//  UINavigationBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

/**
 Protocol describing an object that provides a navigation bar appearance.
 */
public protocol UINavigationBarAppearanceProvider {
    
    /**
     The navigation bar's preferred appearance.
     */
    var preferredNavigationBarAppearance: UINavigationBarAppearance { get }
    
}

/**
 Class containing the various properties of a `UINavigationBar`'s appearance.
 */
public class UINavigationBarAppearance {
    
    /**
     The navigation bar's color; _defaults to white_.
     */
    public var barColor: UIColor = UIColor.white
    
    /**
     The navigation bar's item color; _defaults to black_.
     */
    public var itemColor: UIColor = UIColor.black
    
    /**
     The navigation bar's title font; _defaults to preferred(headline)_.
     */
    public var titleFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
    
    /**
     The navigation bar's title color; _defaults to black_.
     */
    public var titleColor: UIColor = UIColor.black
    
    /**
     Flag indicating whether the navigation bar is hidden or not; _defaults to false_.
     */
    public var hidden: Bool = false
    
    /**
     Flag indicating whether the navigation bar is transparent; _defaults to false_.
     */
    public var transparent: Bool = false
    
    /**
     Flag indicates whether the navigation bar's back button is hidden or not; _defaults to false_.
     */
    public var backButtonHidden: Bool = false
    
    /**
     The navigation bar's back button image.
     */
    public var backButtonImage: UIImage?
    
    /**
     The navigation bar's back button title.
     */
    public var backButtonTitle: String?
    
    // MARK: iOS 11+ /////////////////////////////////////
    
    /**
     The navigation bar's large title display mode; _defaults to never_.
     */
    public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode!
    
    /**
     The navigation bar's large title font; _defaults to preferred(largeTitle)_.
     */
    public var largeTitleFont: UIFont!
    
    /**
     The navigation bar's large title color; _defaults to black_.
     */
    public var largeTitleColor: UIColor = UIColor.black
    
    //////////////////////////////////////////////////////
    
    /**
     Attempts to infer a navigation bar appearance from a specified view controller.
     
     - Parameter viewController: The view controller to infer from.
     - Returns: A navigation bar appearance with inferred values.
     */
    public static func inferred(for viewController: UIViewController) -> UINavigationBarAppearance? {
        
        guard let nav = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return nil }
        guard let topVC = nav.topViewController, topVC != viewController else { return nil } // If comparing to the inferring vc, stop.
        
        if let provider = topVC as? UINavigationBarAppearanceProvider {
            return provider.preferredNavigationBarAppearance
        }
        
        let `default` = UINavigationBarAppearance()
        let bar = topVC.navigationController?.navigationBar
        
        let barColor = bar?.barTintColor ?? `default`.barColor
        let itemColor = bar?.tintColor ?? `default`.itemColor
        let titleFont = (bar?.titleTextAttributes?[.font] as? UIFont) ?? `default`.titleFont
        let titleColor = (bar?.titleTextAttributes?[.foregroundColor] as? UIColor) ?? `default`.titleColor
        let hidden = topVC.navigationController?.isNavigationBarHidden ?? `default`.hidden
        
        // FIXME:
        // Not exactly accurate. We're assuming if a custom background image & shadow are set, the bar is transparent.
        // We're doing this because to make our navigation bar transparent, we're setting empty background & shadow images.
        // Technically, if someone actually sets custom images, this could return the wrong value.
        
        let transparent = ((bar?.backgroundImage(for: .default) != nil) && (bar?.shadowImage != nil)) ? true : false
        
        let appearance = UINavigationBarAppearance(barColor: barColor,
                                                   itemColor: itemColor,
                                                   titleFont: titleFont,
                                                   titleColor: titleColor,
                                                   hidden: hidden,
                                                   transparent: transparent)
        
        if #available(iOS 11, *) {
            appearance.largeTitleDisplayMode = topVC.navigationItem.largeTitleDisplayMode
            appearance.largeTitleFont = (bar?.largeTitleTextAttributes?[.font] as? UIFont) ?? `default`.largeTitleFont
            appearance.largeTitleColor = (bar?.largeTitleTextAttributes?[.foregroundColor] as? UIColor) ?? `default`.largeTitleColor
        }
        
        return appearance
        
    }
    
    /**
     Initializes a new navigation bar appearance with default values.
     */
    public init() {
        
        if #available(iOS 11, *) {
            largeTitleDisplayMode = .never
            largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        }
        
    }
    
    /**
     Initializes a new navigation bar appearance with specified parameters.
     
     - Parameter barColor: The nvaigation bar's color.
     - Parameter itemColor: The navigation bar's item color.
     - Parameter titleFont: The navigation bar's title font.
     - Parameter titleColor: The navigation bar's title color.
     - Parameter hidden: Flag indicating whether the navigation bar is hidden or not.
     - Parameter transparent: Flag indicating whether the navigation bar is transparent or not.
     */
    public convenience init(barColor: UIColor,
                            itemColor: UIColor,
                            titleFont: UIFont,
                            titleColor: UIColor,
                            hidden: Bool,
                            transparent: Bool) {
        
        self.init()
        self.barColor = barColor
        self.itemColor = itemColor
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.hidden = hidden
        self.transparent = transparent
        
    }
    
}
