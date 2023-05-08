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
        
    /// The environment override.
    ///
    /// Setting this will lock the environment to a specific value.
    public static var override: Environment?
        
    /// The current environment.
    ///
    /// The environment is determined using the current process's
    /// launch arguments, environment variables, & compiler flags.
    /// Launch arguments will be evaluated first, followed by
    /// environment variables & compiler flags. If an environment isn't specified,
    /// `production` will be returned.
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
    /// Testing = (TEST, TESTING, QA, UAT)
    /// Staging = (STG, STAGE, STAGING)
    /// Pre-Production = (PRE, PREPROD)
    /// ```
    public static var current: Environment {
        
        if let override {
            return override
        }
                
        // Environment Variables & Launch Args

        var envString: String?
        
        if let envVar = ProcessInfo.processInfo.environment["environment"] {
            envString = envVar.lowercased()
        }
        
        if let envArg = ProcessInfo.processInfo.arguments
            .first(where: { $0.contains("-environment=") }) {
            
            let components = envArg
                .replacingOccurrences(of: " ", with: "")
                .components(separatedBy: "=")
            
            if components.count > 1 {
                
                envString = components[1]
                    .lowercased()
                
            }
            
        }
        
        if let string = envString {
            
            var env: Environment?
            
            switch string {
            case "dev",
                 "develop",
                 "development",
                 "debug":

                env = .development

            case "test",
                 "testing",
                 "qa",
                 "uat":

                env = .testing

            case "stg",
                 "stage",
                 "staging":

                env = .staging

            case "pre",
                 "preprod":

                env = .preproduction

            default:
                
                break
                
            }
            
            if let env {
                return env
            }
            
        }
        
        // Compiler Flags
        
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
    
    // MARK: Flags
    
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
        
    /// Flag indicating if the environment is `development`
    /// _or_ `testing`.
    public var isDevelopmentOrTesting: Bool {
        return self.isDevelopment || self.isTesting
    }
    
    /// Flag indicating if the environment is `development`,
    /// `testing`, _or_ connected to a debug session.
    public var isDevelopmentOrTestingOrDebug: Bool {
        return self.isDevelopment || self.isTesting || ProcessInfo.processInfo.isDebugSessionAttached
    }

    /// Flag indicating if the environment is `development`
    /// _or_ connected to a debug session.
    public var isDevelopmentOrDebug: Bool {
        return self.isDevelopment || ProcessInfo.processInfo.isDebugSessionAttached
    }
    
}
