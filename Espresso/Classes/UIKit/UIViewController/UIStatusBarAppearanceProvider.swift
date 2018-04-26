//
//  UIStatusBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public protocol UIStatusBarAppearanceProvider {
    var preferredStatusBarAppearance: UIStatusBarAppearance { get }
}

public class UIStatusBarAppearance {
    
    public var style: UIStatusBarStyle = .default
    public var hidden: Bool = false
    public var animation: UIStatusBarAnimation = .fade
    
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
    
    public init() {
        //
    }
    
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
