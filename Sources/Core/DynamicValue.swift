//
//  DynamicValue.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import Foundation

/// A dynamic value wrapper that represents 
/// concrete (or default) and placeholder values.
public struct DynamicValue<T> {
    
    /// The current value.
    public var value: T
    
    /// The placeholder value.
    public let placeholder: T
    
    /// Initializes a dynamic value with a
    /// current and placeholder values.
    ///
    /// - parameter value: The current value.
    /// - parameter placeholder: The placeholder value.
    public init(value: T,
                placeholder: T) {
        
        self.value = value
        self.placeholder = placeholder
        
    }
    
    /// Gets the current or placeholder value.
    /// - parameter placeholder: Flag indicating if a placeholder value should be returned.
    /// - returns: A current _or_ placeholder value.
    public func value(placeholder: Bool = false) -> T {
        
        return placeholder ?
            self.placeholder :
            self.value
        
    }
    
}
