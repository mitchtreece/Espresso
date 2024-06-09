//
//  Trait.swift
//  Espresso
//
//  Created by Mitch Treece on 5/9/24.
//

import Foundation

/// An object representing a key/value trait that can be
/// passed down to, or inherited from a trait collection.
public struct Trait: Equatable {
    
    public static func == (lhs: Trait, rhs: Trait) -> Bool {
        return lhs.key == rhs.key
    }
    
    /// The trait's key.
    public let key: String
    
    /// The trait's value.
    public let value: Any
    
    /// Flag indicating if the trait can be inherited.
    public let isInheritable: Bool
    
    /// Initializes a trait.
    /// - parameter key: The trait's key.
    /// - parameter value: The trait's value.
    /// - parameter inheritable: Flag indicating if the trait can be inherited.
    public init(key: String,
                value: Any,
                inheritable: Bool = true) {
        
        self.key = key
        self.value = value
        self.isInheritable = inheritable
        
    }
    
    /// Gets the trait's value as a casted type.
    /// - parameter type: The type to cast the value as.
    /// - returns: A casted value, or `nil`.
    public func value<T>(as type: T.Type) -> T? {
        return self.value as? T
    }
    
}

extension Trait: CustomStringConvertible,
                 CustomDebugStringConvertible {
    
    public var description: String {
        
        var message = "Trait {\n"
        message += "  key: \"\(self.key)\",\n"
        message += "  value: \(type(of: self.value))\n"
        message += "}"
        return message
        
    }
    
    public var debugDescription: String {
        return self.description
    }
    
}
