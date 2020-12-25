//
//  KeyStore.swift
//  Espresso
//
//  Created by Mitch Treece on 12/24/20.
//

import Foundation

/// Protocol that describes a keyed data-store.
public protocol KeyStore: Store {
    
    /// Retrieves a value from the store using a unique key.
    /// - parameter key: The unique key.
    /// - returns: The associated value.
    func get<T>(_ key: String) -> T?
    
    /// Saves a value to the store using a unique key.
    /// - parameter value: The value to save.
    /// - parameter key: The unique key.
    func set(value: Any?, for key: String)
    
}

public extension KeyStore {
    
    /// Retrieves a value from the store using a unique key.
    /// - parameter key: The unique key.
    /// - returns: The associated value.
    func get<T>(_ key: Key) -> T? {
        return get(key.value)
    }
    
    /// Saves a value to the store using a unique key.
    /// - parameter value: The value to save.
    /// - parameter key: The unique key.
    func set(value: Any?, for key: Key) {
        set(value: value, for: key.value)
    }
    
}

extension UserDefaults: KeyStore {

    public func get<T>(_ key: String) -> T? {
        return value(forKey: key) as? T
    }
    
    public func set(value: Any?, for key: String) {
        setValue(value, forKey: key)
    }
    
}
