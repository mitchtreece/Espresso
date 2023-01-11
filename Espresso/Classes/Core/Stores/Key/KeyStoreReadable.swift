//
//  KeyStoreReadable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/7/22.
//

import Foundation

/// Protocol that describes a readable keyed data-store.
public protocol KeyStoreReadable: Store {
    
    /// Retrieves a value from the store using a unique key.
    /// - parameter key: The unique key.
    /// - returns: The associated value.
    func get<T>(_ key: String) -> T?
    
}

public extension KeyStoreReadable /* Key */ {
    
    /// Retrieves a value from the store using a unique key.
    /// - parameter key: The unique key.
    /// - returns: The associated value.
    func get<T>(_ key: Key) -> T? {
        return get(key.value)
    }
    
}
