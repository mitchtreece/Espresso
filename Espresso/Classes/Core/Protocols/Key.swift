//
//  Key.swift
//  Espresso
//
//  Created by Mitch Treece on 12/24/20.
//

import Foundation

/// Protocol describing a unique key.
public protocol Key {
    
    /// The key's string value.
    var value: String { get }
    
}

public extension Key where Self: RawRepresentable, Self.RawValue == String {
    
    var value: String {
        return self.rawValue
    }
    
}
