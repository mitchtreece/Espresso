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
        
        guard let rootVC = keyWindow?.rootViewController else { return UIStatusBarAppearance() }
        
        let appearance = UIStatusBarAppearance()
        
        if let nav = rootVC as? UINavigationController {
            
            let style = nav.topViewController?.preferredStatusBarStyle ?? appearance.style
            let hidden = nav.topViewController?.prefersStatusBarHidden ?? appearance.hidden
            let animation = nav.topViewController?.preferredStatusBarUpdateAnimation ?? appearance.animation
            return UIStatusBarAppearance(style: style, hidden: hidden, animation: animation)
            
        }
        else if let tab = rootVC as? UITabBarController {
            
            let style = tab.selectedViewController?.preferredStatusBarStyle ?? appearance.style
            let hidden = tab.selectedViewController?.prefersStatusBarHidden ?? appearance.hidden
            let animation = tab.selectedViewController?.preferredStatusBarUpdateAnimation ?? appearance.animation
            return UIStatusBarAppearance(style: style, hidden: hidden, animation: animation)
            
        }
        
        return appearance
        
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
