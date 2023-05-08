//
//  UIApplication+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

private struct AssociatedKeys {
    static var publishers: UInt8 = 0
}

public extension UIApplication /* Publishers */ {
    
    /// The application's publishers.
    var publishers: UIApplicationPublishers {
        
        if let publishers = objc_getAssociatedObject(self, &AssociatedKeys.publishers) as? UIApplicationPublishers {
            return publishers
        }

        let publishers = UIApplicationPublishers()

        objc_setAssociatedObject(
            self,
            &AssociatedKeys.publishers,
            publishers,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        return publishers
        
    }
    
}

public extension UIApplication /* Windows & View Controllers */ {
    
    /// The application's key windows.
    var keyWindows: [UIWindow] {
    
        return self.windows
            .filter { $0.isKeyWindow }
        
    }
    
    /// The application's first key window.
    var firstKeyWindow: UIWindow? {
        return self.keyWindows.first
    }
    
    /// The application's first active window.
    var activeWindow: UIWindow? {
        
        if #available(iOS 15, *) {
            return (self.connectedScenes.first as? UIWindowScene)?.windows.first
        }
        else {
            return self.windows.first
        }
        
    }
    
    /// The application's active keyboard window.
    var keyboardWindow: UIWindow? {
        
        return self.windows
            .first(where: { NSStringFromClass($0.classForCoder) == "UIRemoteKeyboardWindow" })
        
    }
    
    /// Gets the top-most (key) `UIViewController` in a given root view controller.
    /// - Parameter root: The root `UIViewController`. _defaults to UIApplication.shared.keyWindow?.rootViewController_.
    /// - Returns: The top-most (key) view controller in the root view controller.
    func keyViewController(in root: UIViewController? = UIApplication.shared.firstKeyWindow?.rootViewController) -> UIViewController? {
        
        if let presented = root?.presentedViewController {
            return keyViewController(in: presented)
        }
        else if let nav = root as? UINavigationController {
            return keyViewController(in: nav.visibleViewController)
        }
        else if let tab = root as? UITabBarController,
            let selectedViewController = tab.selectedViewController {
            return keyViewController(in: selectedViewController)
        }
        
        return root
        
    }
    
}

public extension UIApplication /* Version & Build */ {
    
    /// The application's bundle identifier _(CFBundleIdentifier)_.
    var bundleId: String? {
        return Bundle.main.bundleIdentifier
    }
    
    /// The application's version string _(CFBundleShortVersionString)_.
    var version: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// The application's build number string _(CFBundleVersion)_.
    var build: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
