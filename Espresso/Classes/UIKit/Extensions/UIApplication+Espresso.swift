//
//  UIApplication+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

private struct AssociatedKeys {
    static var environmentOverride: UInt8 = 0
}

public extension UIApplication {
    
    /// The application's active keyboard window.
    var keyboardWindow: UIWindow? {
        
        return self.windows
            .first(where: { NSStringFromClass($0.classForCoder) == "UIRemoteKeyboardWindow" })
        
    }
    
    /// Gets the top-most (key) `UIViewController` in a given root view controller.
    /// - Parameter root: The root `UIViewController`. _defaults to UIApplication.shared.keyWindow?.rootViewController_.
    /// - Returns: The top-most (key) view controller in the root view controller.
    func keyViewController(in root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
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
    
    /// The application's version string _(CFBundleShortVersionString)_.
    var version: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// The application's build number string _(CFBundleVersion)_.
    var build: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}

public extension UIApplication /* Environment */ {
    
    /// Representation of the various application environments.
    enum Environment: String {
        
        /// A development environment.
        case development = "dev"
        
        /// A staging environment.
        case staging = "stg"
        
        /// A pre-production environment.
        case preproduction = "preprod"
        
        /// A production environment.
        case production = "prod"
        
        /// The environment's short name.
        public var shortName: String {
            return self.rawValue
        }
        
        /// The environment's long name.
        public var longName: String {
            
            switch self {
            case .development: return "development"
            case .staging: return "staging"
            case .preproduction: return "pre-production"
            case .production: return "production"
            }
            
        }
        
        /// Flag indicating if the environment is `development`.
        public var isDevelopment: Bool {
            
            switch self {
            case .development: return true
            default: return false
            }
            
        }
        
        /// Flag indicating if the environment is `production`.
        public var isProduction: Bool {
            
            switch self {
            case .production: return true
            default: return false
            }
            
        }
        
    }
    
    /// The application's environment override.
    ///
    /// Setting this will lock the application to a specific environment.
    var environmentOverride: Environment? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.environmentOverride) as? Environment else { return nil }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.environmentOverride, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// The application's current environment.
    var environment: Environment {
        
        if let override = environmentOverride {
            return override
        }
        
        #if DEBUG
            return Environment.development
        #elseif STAGING
            return Environment.staging
        #elseif PREPROD
            return Environment.preproduction
        #else
            return Environment.production
        #endif
        
    }
    
}
