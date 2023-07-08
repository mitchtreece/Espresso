//
//  Environment.swift
//  Espresso
//
//  Created by Mitch Treece on 5/7/23.
//

import Foundation

/// Representation of the various application environments.
public enum Environment: String {
    
    /// A development environment.
    case development = "dev"
    
    /// A local development environment.
    case developmentLocal = "dev_local"
    
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
        case .developmentLocal: return "development-local"
        case .testing: return "testing"
        case .staging: return "staging"
        case .preproduction: return "pre-production"
        case .production: return "production"
        }
        
    }
    
    /// The environment's launch arguments.
    public var arguments: [String] {
        
        return ProcessInfo
            .processInfo
            .arguments
        
    }
    
    /// The environment's variables.
    public var variables: [String: String] {
        
        return ProcessInfo
            .processInfo
            .environment
        
    }
    
    /// Flag indicating if the process is currently attached to a debug session.
    ///
    /// This will likely (but not always) be an Xcode debug session.
    public var isDebugSessionAttached: Bool {
        
        return ProcessInfo
            .processInfo
            .isDebugSessionAttached
        
    }
    
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
        case .development,
             .developmentLocal:
            
            return true
            
        default: return false
        }
        
    }
        
    /// Flag indicating if the environment is `development`
    /// _or_ `testing`.
    public var isDevelopmentOrTesting: Bool {
        return self.isDevelopment || self.isTesting
    }
    
    /// Flag indicating if the environment is `development`,
    /// `testing`, _or_ connected to a debug session.
    public var isDevelopmentOrTestingOrDebug: Bool {
        return self.isDevelopment || self.isTesting || self.isDebugSessionAttached
    }

    /// Flag indicating if the environment is `development`
    /// _or_ connected to a debug session.
    public var isDevelopmentOrDebug: Bool {
        return self.isDevelopment || self.isDebugSessionAttached
    }
    
    /// The environment override.
    ///
    /// Setting this will lock the environment to a specific value.
    public static var override: Environment?
        
    /// The current environment.
    ///
    /// The environment is determined using the current process's
    /// bundled info plist, launch arguments, environment variables, & compiler flags.
    /// Info plist entries are evaluated first, followed by launch arguments,
    /// environment variables, & compiler flags. If an environment isn't specified,
    /// `production` will be returned.
    ///
    /// An info plist entry can be added using the following key/value format:
    /// `Environment: {e}`, where `{e}` is replaced by your desired environment.
    ///
    /// Launch arguments can be specified using the following format:
    /// `-environment={e}`, where `{e}` is replaced by your desired environment.
    ///
    /// Environment variables can be specified using the following key/value format:
    /// `environment: {e}`, where `{e}` is replaced by your desired environment
    ///
    /// Compiler flags can be specified by adding an entry to your
    /// project's Build Settings → Swift Compiler - Custom Flags →
    /// Active Compilation Conditions.
    ///
    /// Supported environments:
    ///
    /// ```
    /// Development = (DEV, DEVELOP, DEVELOPMENT, DEBUG)
    /// Development-Local = (DEV_LOCAL, DEVELOP_LOCAL, DEVELOPMENT_LOCAL, DEBUG_LOCAL)
    /// Testing = (TEST, TESTING, QA, UAT)
    /// Staging = (STG, STAGE, STAGING)
    /// Pre-Production = (PRE, PRE_PROD, PRE_PRODUCTION)
    /// Production = (PROD, PRODUCTION)
    /// ```
    ///
    /// **Note**
    ///
    /// Launch arguments & environment variables are stripped out of
    /// packaged builds. These will only work when building directly
    /// from an Xcode scheme.
    ///
    /// Compiler flags are *module* specific. Meaning, if you've integrated Espresso
    /// using SPM, they cannot be read at compile-time.
    ///
    /// **Adding an info plist entry is the preferred method of specifying an environment.**
    /// This method works when building from Xcode, or when running via a packaged build.
    public static var current: Environment {
        
        if let override {
            return override
        }
                
        // Info plist
        
        if let string = Bundle.main.infoDictionary?["Environment"] as? String,
           let env = environment(from: string) {
            
            return env
            
        }
        else if let string = Bundle.main.infoDictionary?["environment"] as? String,
                let env = environment(from: string) {
            
            return env
            
        }
                
        // Environment Variables & Launch Args

        let processInfo = ProcessInfo.processInfo
        var envString: String?
        
        if let envVar = processInfo.environment["environment"] {
            envString = envVar.lowercased()
        }
        
        if let envArg = processInfo.arguments
            .first(where: { $0.contains("-environment=") }) {
            
            let components = envArg
                .replacingOccurrences(of: " ", with: "")
                .components(separatedBy: "=")
            
            if components.count > 1 {
                
                envString = components[1]
                    .lowercased()
                
            }
            
        }
        
        if let string = envString,
           let env = environment(from: string) {
            
            return env
            
        }
        
        // Compiler Flags
                
        #if DEV || DEVELOP || DEVELOPMENT || DEBUG
        return .development
        #elseif DEV_LOCAL || DEVELOP_LOCAL || DEVELOPMENT_LOCAL || DEBUG_LOCAL
        return .localDevelopment
        #elseif TEST || TESTING || QA || UAT
        return .testing
        #elseif STG || STAGE || STAGING
        return .staging
        #elseif PRE || PRE_PROD || PRE_PRODUCTION
        return .preproduction
        #elseif PROD || PRODUCTION
        return .production
        #else
        return .production
        #endif
        
    }
    
    private static func environment(from string: String) -> Environment? {
        
        switch string {
        case "dev",
             "develop",
             "development",
             "debug":

            return .development
            
        case "dev_local",
             "develop_local",
             "development_local",
             "debug_local":
            
            return .developmentLocal

        case "test",
             "testing",
             "qa",
             "uat":

            return .testing

        case "stg",
             "stage",
             "staging":

            return .staging

        case "pre",
             "pre_prod",
             "pre_production":

            return .preproduction
            
        case "prod",
             "production":
            
            return .production

        default:
            
            return nil
            
        }
        
    }
    
}
