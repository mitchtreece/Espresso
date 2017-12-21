//
//  UIStatusBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public class UIStatusBarAppearance {
    
    public var style: UIStatusBarStyle?
    public var hidden: Bool?
    public var animation: UIStatusBarAnimation?
    
    public static var `default`: UIStatusBarAppearance {
        return UIStatusBarAppearance(style: .default, hidden: false, animation: .fade)
    }
    
    public static func forViewController(_ vc: UIViewController) -> UIStatusBarAppearance {
        
        return UIStatusBarAppearance(style: vc.preferredStatusBarStyle,
                                     hidden: vc.prefersStatusBarHidden,
                                     animation: vc.preferredStatusBarUpdateAnimation)
        
    }
    
    public init(style: UIStatusBarStyle?, hidden: Bool?, animation: UIStatusBarAnimation?) {
        
        self.style = style
        self.hidden = hidden
        self.animation = animation
        
    }
    
    // Helpers
    
    public func style(_ style: UIStatusBarStyle?) -> Self {
        self.style = style
        return self
    }
    
    public func hidden(_ hidden: Bool?) -> Self {
        self.hidden = hidden
        return self
    }
    
    public func animation(_ animation: UIStatusBarAnimation?) -> Self {
        self.animation = animation
        return self
    }
    
}

public protocol UIStatusBarAppearanceProvider {
    var preferredStatusBarAppearance: UIStatusBarAppearance? { get }
}
