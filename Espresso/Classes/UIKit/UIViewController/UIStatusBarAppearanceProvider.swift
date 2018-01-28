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
    
    static func inferred(from viewController: UIViewController) -> UIStatusBarAppearance? {
        
        guard var vc = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        
        if let nav = vc as? UINavigationController, let topVC = nav.topViewController {
            vc = topVC
        }
        else if let tab = vc as? UITabBarController, let selectedVC = tab.selectedViewController {
            vc = selectedVC
        }
        
        // If comparing to the inferring vc, stop.
        guard vc != viewController else { return nil }
        
        if let provider = vc as? UIStatusBarAppearanceProvider {
            return provider.preferredStatusBarAppearance
        }
        
        let style = vc.preferredStatusBarStyle
        let hidden = vc.prefersStatusBarHidden
        let animation = vc.preferredStatusBarUpdateAnimation
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
