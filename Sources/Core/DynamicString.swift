//
//  DynamicString.swift
//  Espresso
//
//  Created by Mitch Treece on 3/6/24.
//

import Foundation

/// A dynamic string wrapper that represents
/// concrete (or default) and placeholder values.
public struct DynamicString {
    
    private var _value: String
    
    /// The current value.
    var value: String {
        get { self._value }
        set { self._value = self.isLocalized ? .localized(newValue) : newValue }
    }
    
    /// The placeholder value.
    public let placeholder: String
    
    /// Flag indicating if the values should be localized.
    public let isLocalized: Bool
    
    /// Initializes a dynamic-string with an initial value & placeholder.
    /// - parameter value: The initial value.
    /// - parameter placeholder: The placeholder value.
    /// - parameter localized: Flag indicating if values should be localized.
    public init(_ value: String,
                placeholder: String = .placeholder(.medium),
                localized: Bool = true) {
        
        self._value = localized ? .localized(value) : value
        self.placeholder = placeholder
        self.isLocalized = localized
        
    }
    
    /// Gets the current or placeholder value.
    /// - parameter placeholder: Flag indicating if a placeholder value should be returned.
    /// - returns: A current _or_ placeholder value.
    public func value(placeholder: Bool = false) -> String {
        
        return placeholder ?
            self.placeholder :
            self.value
        
    }
    
}
