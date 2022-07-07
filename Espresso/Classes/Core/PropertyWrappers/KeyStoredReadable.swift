//
//  KeyStoredReadable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/7/22.
//

import Foundation

/// Marks a property as being backed by a readable keyed data-store.
@propertyWrapper
public struct KeyStoredReadable<T> {
    
    private let key: String
    private let defaultValue: T?
    private let store: KeyStoreReadable
    
    public var wrappedValue: T? {
        get {
            return self.store.get(self.key) ?? self.defaultValue
        }
    }
    
    /// Initializes a `KeyStoredReadable` property wrapper.
    /// - parameter key: The unique key used when reading from the store.
    /// - parameter default: A default value used when reading an empty value from the store; _defaults to nil_.
    /// - parameter store: The store to read from; _defaults to UserDefaults.standard_.
    public init(_ key: Key,
                default: T? = nil,
                store: KeyStoreReadable = UserDefaults.standard) {
        
        self.key = key.value
        self.defaultValue = `default`
        self.store = store
        
    }
    
    /// Initializes a `KeyStoredReadable` property wrapper.
    /// - parameter key: The unique key used when reading from the store.
    /// - parameter default: A default value used when reading an empty value from the store; _defaults to nil_.
    /// - parameter store: The store to read from; _defaults to UserDefaults.standard_.
    public init(_ key: String,
                default: T? = nil,
                store: KeyStoreReadable = UserDefaults.standard) {
                
        self.key = key
        self.defaultValue = `default`
        self.store = store
        
    }
    
}
