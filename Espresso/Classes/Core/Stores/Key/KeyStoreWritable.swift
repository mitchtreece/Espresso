//
//  KeyStoreWritable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/7/22.
//

import Foundation

/// Protocol that describes a writable keyed data-store.
public protocol KeyStoreWritable: Store {
    
    /// Saves a value to the store using a unique key.
    /// - parameter value: The value to save.
    /// - parameter key: The unique key.
    func set(value: Any?, for key: String)
    
}

public extension KeyStoreWritable /* Key */ {
    
    /// Saves a value to the store using a unique key.
    /// - parameter value: The value to save.
    /// - parameter key: The unique key.
    func set(value: Any?, for key: Key) {
        set(value: value, for: key.value)
    }
    
}

public extension KeyStoreWritable /* Clear */ {
    
    /// Clears a value from the store associated with a given key.
    /// - parameter key: The key.
    func clear(key: String) {
        self.set(value: nil, for: key)
    }
    
    /// Clears a value from the store associated with a given key.
    /// - parameter key: The key.
    func clear(key: Key) {
        self.set(value: nil, for: key)
    }
    
}
