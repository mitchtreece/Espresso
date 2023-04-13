//
//  UIApplication+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

private struct AssociatedKeys {
    
    static var publishers: UInt8 = 0
    static var environmentOverride: UInt8 = 0
    
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

public extension UIApplication /* Environment */ {
    
    /// Representation of the various application environments.
    enum Environment: String {
        
        /// A development environment.
        case development = "dev"
        
        /// A testing environment.
        case testing = "test"
        
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
            case .testing: return "testing"
            case .staging: return "staging"
            case .preproduction: return "pre-production"
            case .production: return "production"
            }
            
        }
        
        // MARK: Environment Flags
        
        /// Flag indicating if the environment is `production`.
        public var isProduction: Bool {
            
            switch self {
            case .production: return true
            default: return false
            }
            
        }
        
        /// Flag indicating if the environment is `testing`.
        public var isTesting: Bool {
            
            switch self {
            case .testing: return true
            default: return false
            }
            
        }
        
        /// Flag indicating if the environment is `development`.
        public var isDevelopment: Bool {
            
            switch self {
            case .development: return true
            default: return false
            }
            
        }
        
        // MARK: Environment Aggregate Flags
        
        /// Flag indicating if the environment is `development`
        /// _or_ `testing`.
        public var isDevelopmentOrTesting: Bool {
            return self.isDevelopment || self.isTesting
        }
        
        /// Flag indicating if the environment is `development`,
        /// `testing`, _or_ connected to a debug session.
        public var isDevelopmentOrTestingOrDebug: Bool {
            return self.isDevelopment || self.isTesting || UIApplication.shared.isDebugSessionAttached
        }
        
        /// Flag indicating if the environment is `development`
        /// _or_ connected to a debug session.
        public var isDevelopmentOrDebug: Bool {
            return self.isDevelopment || UIApplication.shared.isDebugSessionAttached
        }
        
    }
    
    /// The application's current environment.
    var environment: Environment {
        
        if let override = self.environmentOverride {
            return override
        }
        
        #if DEV || DEVELOP || DEVELOPMENT || DEBUG
        return .development
        #elseif TEST || TESTING || QA || UAT
        return .testing
        #elseif STG || STAGE || STAGING
        return .staging
        #elseif PRE || PREPROD
        return .preproduction
        #else
        return .production
        #endif
        
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
    
}

public extension UIApplication /* Debug */ {
    
    /// Flag indicating if the application is currently attached to a debug session.
    ///
    /// This will likely (but not always) be an Xcode debug session.
    var isDebugSessionAttached: Bool {
                    
        var isAttached: Bool = false
        
        var name: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var info: kinfo_proc = kinfo_proc()
        var infoSize = MemoryLayout<kinfo_proc>.size
        
        let success = name.withUnsafeMutableBytes { ptr -> Bool in
            
            guard let address = ptr
                .bindMemory(to: Int32.self)
                .baseAddress else { return false }
            
            return (sysctl(address, 4, &info, &infoSize, nil, 0) != -1)
            
        }
        
        if !success {
            isAttached = false
        }
        
        if !isAttached && (info.kp_proc.p_flag & P_TRACED) != 0 {
            isAttached = true
        }

        return isAttached
        
    }
    
}