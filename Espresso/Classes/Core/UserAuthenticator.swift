//
//  UserAuthenticator.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation
import LocalAuthentication

/// `UserAuthenticator` is an authentication helper for biometrics (Touch ID, Face ID) or a device password.
public final class UserAuthenticator {
    
    /// Representation of the various user-authentication methods.
    public enum Method {
        
        /// A user-authentication method that represents the absence of an authentication method.
        case none
        
        /// A device password user-authentication method.
        case password
        
        /// A biometric user-authentication method using Touch ID.
        case touchId
        
        /// A biometric user-authentication method using Face ID.
        case faceId
        
        /// The user-authentication method's display name.
        ///
        /// This value will be `nil` if the user-authentication method is `none`.
        public var displayName: String? {
            
            switch self {
            case .password: return "Password"
            case .touchId: return "Touch ID"
            case .faceId: return "Face ID"
            default: return nil
            }
            
        }
        
    }
    
    private static var authenticationContext: LAContext? {
        
        let context = LAContext()
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) else { return nil }
        return context
        
    }
    
    /// The device's preferred user-authentication type.
    public static var preferredAuthenticationMethod: Method {
        get {
            
            guard let context = self.authenticationContext else { return .none }
            
            // We've already asked if the context can evaluate.
            // If we get this far, then we know authentication will
            // happen either with biometrics or a password.
            
            switch context.biometryType {
            case .none: return .password
            case .touchID: return .touchId
            case .faceID: return .faceId
            @unknown default: return .password
            }
            
        }
    }
    
    /// Authenticate's the user using the device's preferred authentication method.
    /// - parameter reason: The reason string to be displayed during authentication.
    /// - parameter completion: The authentication completion handler.
    /// - parameter success: Flag indicating if the authentication was successful.
    /// - parameter error: An optional error returned from the authentication attempt.
    /// - returns: A bool indicating if authentication was successful.
    ///
    /// If you are attempting to authenticate with Face ID, the `NSFaceIDUsageDescription` key **must**
    /// be added to the `Info.plist`. If the key is missing, authentication will fallback to `password` if possible.
    public static func authenticate(withReason reason: String, completion: @escaping (_ success: Bool, _ error: Error?)->()) {
        
        guard let context = self.authenticationContext else {
            completion(false, "Authentication not supported on this device".asError())
            return
        }
        
        context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: reason,
            reply: { (success: Bool, error: Error?) -> Void in
                completion(success, error)
            })
        
    }
    
    /// Authenticate's the user using the device's preferred authentication method.
    /// - parameter reason: The reason string to be displayed during authentication.
    /// - returns: A bool indicating if authentication was successful.
    ///
    /// If you are attempting to authenticate with Face ID, the `NSFaceIDUsageDescription` key **must**
    /// be added to the `Info.plist`. If the key is missing, authentication will fallback to `password` if possible.
    public static func authenticate(withReason reason: String) async throws -> Bool {
        
        return try await withCheckedThrowingContinuation { c in
            
            authenticate(withReason: reason) { success, error in
                
                if let error = error {
                    
                    c.resume(throwing: error)
                    return
                    
                }
                
                c.resume(returning: success)
                
            }
            
        }
        
    }
    
}
