//
//  UIApplication+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public extension UIApplication {
    
    var statusBarAppearance: UIStatusBarAppearance {
        
        guard let rootVC = keyWindow?.rootViewController else { return (.default, false) }
        
        if let nav = rootVC as? UINavigationController {
            
            let style = nav.topViewController?.preferredStatusBarStyle ?? .default
            let hidden = nav.topViewController?.prefersStatusBarHidden ?? false
            return (style, hidden)
            
        }
        else if let tab = rootVC as? UITabBarController {
            
            let style = tab.selectedViewController?.preferredStatusBarStyle ?? .default
            let hidden = tab.selectedViewController?.prefersStatusBarHidden ?? false
            return (style, hidden)
            
        }
        
        return (rootVC.preferredStatusBarStyle, rootVC.prefersStatusBarHidden)
        
    }
    
    var keyboardWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { NSStringFromClass($0.classForCoder) == "UIRemoteKeyboardWindow" })
    }
    
}
