//
//  UIApplication+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

// MARK: UIStatusBar

public extension UIApplication /* UIStatusBarAppearance */ {
    
    /**
     The application's current status bar appearance.
     */
    public var statusBarAppearance: UIStatusBarAppearance {
        
        guard let rootVC = keyWindow?.rootViewController else { return UIStatusBarAppearance() }
        
        let `default` = UIStatusBarAppearance()
        
        if let nav = rootVC as? UINavigationController {
            
            let style = nav.topViewController?.preferredStatusBarStyle ?? `default`.style
            let hidden = nav.topViewController?.prefersStatusBarHidden ?? `default`.hidden
            let animation = nav.topViewController?.preferredStatusBarUpdateAnimation ?? `default`.animation
            return UIStatusBarAppearance(style: style, hidden: hidden, animation: animation)
            
        }
        else if let tab = rootVC as? UITabBarController {
            
            let style = tab.selectedViewController?.preferredStatusBarStyle ?? `default`.style
            let hidden = tab.selectedViewController?.prefersStatusBarHidden ?? `default`.hidden
            let animation = tab.selectedViewController?.preferredStatusBarUpdateAnimation ?? `default`.animation
            return UIStatusBarAppearance(style: style, hidden: hidden, animation: animation)
            
        }
        
        return `default`
        
    }
    
}

public extension UIApplication /* Keyboard Window */ {
    
    /**
     The application's active keyboard window.
     */
    public var keyboardWindow: UIWindow? {
        return UIApplication.shared.windows.first(where: { NSStringFromClass($0.classForCoder) == "UIRemoteKeyboardWindow" })
    }
    
}

public extension UIApplication /* Environment */ {
    
    private struct AssociatedKeys {
        static var environmentOverride: UInt8 = 0
    }
    
    /**
     Representation of the various application environments.
     */
    public enum Environment: String {
        case development
        case production
    }
    
    /**
     The application's environment override.
     Setting this will lock the application to a specific environment regardless of what it's environment actually is.
     */
    public var environmentOverride: Environment? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.environmentOverride) as? Environment else { return nil }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.environmentOverride, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     The application's current environment.
     */
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

public extension UIApplication /* Version */ {
    
    /**
     The application's version string _(CFBundleShortVersionString)_.
     */
    public var version: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /**
     The application's build number string _(CFBundleVersion)_.
     */
    public var build: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
