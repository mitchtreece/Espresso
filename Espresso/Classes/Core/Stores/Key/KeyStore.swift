//
//  KeyStore.swift
//  Espresso
//
//  Created by Mitch Treece on 12/24/20.
//

import Foundation

/// Protocol that describes a read/write keyed data-store.
public protocol KeyStore: KeyStoreReadable, KeyStoreWritable {
    //
}

extension UserDefaults: KeyStore {

    public func get<T>(_ key: String) -> T? {
        return value(forKey: key) as? T
    }

    public func set(value: Any?, for key: String) {
        setValue(value, forKey: key)
    }

}
