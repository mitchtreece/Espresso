//
//  KeyStored.swift
//  Espresso
//
//  Created by Mitch Treece on 12/24/20.
//

import Foundation

/// Marks a property as being backed by a read/write keyed data-store.
@propertyWrapper
public struct KeyStored<T> {
    
    private let key: String
    private let defaultValue: T?
    private let store: KeyStore
    
    public var wrappedValue: T? {
        get {
            return self.store.get(self.key) ?? self.defaultValue
        }
        set {
            self.store.set(value: newValue, for: self.key)
        }
    }
    
    /// Initializes a `KeyStored` property wrapper.
    /// - parameter key: The unique key used when reading from & writing to the store.
    /// - parameter default: A default value used when reading an empty value from the store; _defaults to nil_.
    /// - parameter store: The store to read from & write to; _defaults to UserDefaults.standard_.
    public init(_ key: Key,
                default: T? = nil,
                store: KeyStore = UserDefaults.standard) {
        
        self.key = key.value
        self.defaultValue = `default`
        self.store = store
        
    }
    
    /// Initializes a `KeyStored` property wrapper.
    /// - parameter key: The unique key used when reading from & writing to the store.
    /// - parameter default: A default value used when reading an empty value from the store; _defaults to nil_.
    /// - parameter store: The store to read from & write to; _defaults to UserDefaults.standard_.
    public init(_ key: String,
                default: T? = nil,
                store: KeyStore = UserDefaults.standard) {
                
        self.key = key
        self.defaultValue = `default`
        self.store = store
        
    }
    
}
