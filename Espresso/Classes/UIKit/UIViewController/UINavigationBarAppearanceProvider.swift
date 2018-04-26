//
//  UINavigationBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public protocol UINavigationBarAppearanceProvider {
    
    var preferredNavigationBarAppearance: UINavigationBarAppearance { get }
    
}

public class UINavigationBarAppearance {
    
    public var barColor: UIColor = UIColor.white
    public var itemColor: UIColor = UIColor.black
    public var titleFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
    public var titleColor: UIColor = UIColor.black
    public var hidden: Bool = false
    public var transparent: Bool = false
    
    public var backButtonHidden: Bool = false
    public var backButtonImage: UIImage?
    public var backButtonTitle: String?
    
    // #available(iOS 11, *)
    public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode!
    public var largeTitleFont: UIFont!
    public var largeTitleColor: UIColor = UIColor.black
    
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
    
    public init() {
        
        if #available(iOS 11, *) {
            largeTitleDisplayMode = .never
            largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        }
        
    }
    
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
