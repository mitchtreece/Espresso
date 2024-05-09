//
//  Deferred.swift
//  Espresso
//
//  Created by Mitch Treece on 3/11/24.
//

import Foundation

/// A deferred value wrapper that represents
/// concrete (or default) and placeholder values.
public struct Deferred<T> {
    
    /// The current value.
    public var value: T? {
        didSet {
            
            self._valuePublisher
                .send(value ?? self.defaultValue)
            
        }
    }
    
    /// The default (fallback) value.
    public var defaultValue: T {
        didSet {
            
            self._valuePublisher
                .send(self.value ?? self.defaultValue)
            
        }
    }
    
    /// The placeholder value.
    public var placeholderValue: T?
    
    /// The current _or_ default value.
    public var valueOrDefault: T {
        return resolve(placeholder: false)
    }
    
    /// The placeholder, current, _or_ default value.
    public var placeholderValueOrDefault: T {
        return resolve(placeholder: true)
    }
    
    /// The current _or_ default value publisher.
    public var valuePublisher: GuaranteePublisher<T> {
        return self._valuePublisher.eraseToAnyPublisher()
    }
    
    private let _valuePublisher = GuaranteePassthroughSubject<T>()
    
    /// Initializes a deferred value with
    /// placeholder, current, and default values.
    /// - parameter default: The default value.
    /// - parameter value: The current value.
    /// - parameter placeholder: The placeholder value.
    public init(_ `default`: T,
                value: T? = nil,
                placeholder: T? = nil) {
        
        self.value = value
        self.defaultValue = `default`
        self.placeholderValue = placeholder
        
    }
        
    /// Resolves either a placeholder, current, _or_ default value.
    /// - parameter placeholder: Flag indicating if a placeholder value should be returned.
    /// - returns: A placeholder, current, _or_ default value.
    public func resolve(placeholder: Bool = false) -> T {
        
        return placeholder ?
            self.placeholderValue ?? self.value ?? self.defaultValue :
            self.value ?? self.defaultValue
        
    }
    
}
