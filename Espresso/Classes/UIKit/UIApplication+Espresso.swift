//
//  UIApplication+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

// MARK: UIStatusBar

public extension UIApplication {
    
    public var statusBarAppearance: UIStatusBarAppearance {
        
        guard let rootVC = keyWindow?.rootViewController else { return (.default, false, .fade) }
        
        if let nav = rootVC as? UINavigationController {
            
            let style = nav.topViewController?.preferredStatusBarStyle ?? .default
            let hidden = nav.topViewController?.prefersStatusBarHidden ?? false
            let animation = nav.topViewController?.preferredStatusBarUpdateAnimation ?? .fade
            return (style, hidden, animation)
            
        }
        else if let tab = rootVC as? UITabBarController {
            
            let style = tab.selectedViewController?.preferredStatusBarStyle ?? .default
            let hidden = tab.selectedViewController?.prefersStatusBarHidden ?? false
            let animation = tab.selectedViewController?.preferredStatusBarUpdateAnimation ?? .fade
            return (style, hidden, animation)
            
        }
        
        return (rootVC.preferredStatusBarStyle, rootVC.prefersStatusBarHidden, rootVC.preferredStatusBarUpdateAnimation)
        
    }
    
}

// MARK: Keyboard

public extension UIApplication {
    
    public var keyboardWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { NSStringFromClass($0.classForCoder) == "UIRemoteKeyboardWindow" })
    }
    
}

// MARK: Environment

public extension UIApplication {
    
    private struct AssociatedKeys {
        static var environmentOverride: UInt8 = 0
    }
    
    public enum Environment: String {
        case development
        case production
    }
    
    public var environmentOverride: Environment? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.environmentOverride) as? Environment else { return nil }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.environmentOverride, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var environment: Environment {
        
        if let override = environmentOverride {
            return override
        }
        
        #if DEBUG
            return Environment.development
        #else
            return Environment.production
        #endif
        
    }
    
}

// MARK: Version

public extension UIApplication {
    
    public var version: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var build: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
