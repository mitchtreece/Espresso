//
//  UIApplication+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

#if canImport(UIKit)

import UIKit

private struct AssociatedKeys {
    static var publishers: UInt8 = 0
}

public extension UIApplication /* Scenes */ {
    
    /// The application's connected window scenes.
    var windowScenes: [UIWindowScene] {
        
        return self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        
    }
    
    /// The application's key (first) window scene.
    var keyWindowScene: UIWindowScene? {
        return self.windowScenes.first
    }
    
}

public extension UIApplication /* Windows */ {
    
    /// The application's key windows.
    var keyWindows: [UIWindow] {
        
        return self.windowScenes
            .flatMap { $0.windows }
            .filter { $0.isKeyWindow }
        
    }
    
    /// The application's key (first) scene window.
    var keySceneWindow: UIWindow? {
        
        if #available(iOS 15, *) {
            return self.keyWindowScene?.keyWindow
        }
        else {
            return self.keyWindowScene?.windows.first
        }
        
    }
    
    /// The application's active keyboard window.
    var keyboardWindow: UIWindow? {
        
        return self.windowScenes
            .flatMap { $0.windows }
            .first(where: { NSStringFromClass($0.classForCoder) == "UIRemoteKeyboardWindow" })
        
    }
    
}

public extension UIApplication /* Status Bar */ {
    
    /// The application's key (first) window scene's status bar height.
    var keyStatusBarHeight: CGFloat {
        
        return self.keyWindowScene?
            .statusBarManager?
            .statusBarFrame
            .size
            .height ?? 0
        
    }
    
}

public extension UIApplication /* View Controllers */ {
    
    /// Gets the top-most (key) `UIViewController` in a given root view controller.
    /// - Parameter root: The root `UIViewController`. _defaults to UIApplication.shared.keyWindow?.rootViewController_.
    /// - Returns: The top-most (key) view controller in the root view controller.
    func keyViewController(in root: UIViewController? = UIApplication.shared.keySceneWindow?.rootViewController) -> UIViewController? {
        
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

#endif
