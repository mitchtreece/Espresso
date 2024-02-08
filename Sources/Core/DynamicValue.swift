//
//  DynamicValue.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import Foundation

/// A dynamic value wrapper that represents potential
/// concrete & placeholder values, as-well-as a default fallback value.
public struct DynamicValue<T> {
    
    /// The current value.
    public var value: T?
    
    /// the placeholder value.
    public let placeholder: T?
    
    /// The default value.
    public let `default`: T
    
    /// Initializes a dynamic value with a
    /// current value, placeholder value, & default value.
    ///
    /// - parameter value: The current value.
    /// - parameter placeholder: The placeholder value.
    /// - parameter default: The default value.
    public init(value: T? = nil,
                placeholder: T? = nil,
                `default`: T) {
        
        self.value = value
        self.placeholder = placeholder
        self.default = `default`
        
    }
    
    /// Gets the current/default, or a placeholder value.
    ///
    /// - parameter placeholder: Flag indicating if a placeholder value should be returned.
    /// - returns: A current/default _or_ placeholder value.
    public func value(placeholder: Bool = false) -> T {
        
        return placeholder ?
            self.placeholder ?? self.default :
            self.value ?? self.default
        
    }
    
}
