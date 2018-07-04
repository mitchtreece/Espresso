//
//  UIStatusBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

/**
 Protocol describing an object that provides a status bar appearance.
 */
public protocol UIStatusBarAppearanceProvider {
    
    /**
     The status bar's preferred appearance.
     */
    var preferredStatusBarAppearance: UIStatusBarAppearance { get }
    
}

/**
 Class containing the various properties of a `UIStatusBar`'s appearance.
 */
public class UIStatusBarAppearance {
    
    /**
     The status bar's style; _defaults to default_.
     */
    public var style: UIStatusBarStyle = .default
    
    /**
     Flag indicating whether the status bar is hidden or not; _defaults to false_.
     */
    public var hidden: Bool = false
    
    /**
     The status bar's update animation; _defaults to fade_.
     */
    public var animation: UIStatusBarAnimation = .fade
    
    /**
     Attempts to infer a status bar appearance from a specified view controller.
     
     - Parameter viewController: The view controller to infer from.
     - Returns: A status bar appearance with inferred values.
     */
    public static func inferred(for viewController: UIViewController) -> UIStatusBarAppearance? {
        
        guard var currentVC = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        
        if let nav = currentVC as? UINavigationController, let topVC = nav.topViewController {
            currentVC = topVC
        }
        else if let tab = currentVC as? UITabBarController, let selectedVC = tab.selectedViewController {
            currentVC = selectedVC
        }
        
        // If comparing to the inferring vc, stop. (going back)
        guard currentVC != viewController else { return nil }
        
        if let provider = currentVC as? UIStatusBarAppearanceProvider {
            return provider.preferredStatusBarAppearance
        }
        
        let style = currentVC.preferredStatusBarStyle
        let hidden = currentVC.prefersStatusBarHidden
        let animation = currentVC.preferredStatusBarUpdateAnimation
        return UIStatusBarAppearance(style: style, hidden: hidden, animation: animation)
        
    }
    
    /**
     Initializes a new status bar appearance with default values.
     */
    public init() {
        //
    }
    
    /**
     Initializes a new status bar appearance with specified parameters.
     
     - Parameter style: The status bar's style.
     - Parameter hidden: Flag indicating whether the status bar is hidden or not.
     - Parameter animation: The status bar's update animation.
     */
    public convenience init(style: UIStatusBarStyle, hidden: Bool, animation: UIStatusBarAnimation) {
        
        self.init()
        self.style = style
        self.hidden = hidden
        self.animation = animation
        
    }
    
}

extension UIStatusBarAppearance: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        let _style = (style == .default) ? "default" : "lightContent"
        let _animation = (animation == .none) ? "none" : ((animation == .fade) ? "fade" : "slide")
        return "<UIStatusBarAppearance> {\n\tstyle: \(_style),\n\thidden: \(hidden),\n\tanimation: \(_animation)\n}"
        
    }
    
    public var debugDescription: String {
        return description
    }
    
}
