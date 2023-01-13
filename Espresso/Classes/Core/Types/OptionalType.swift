//
//  OptionalType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that has an optional value.
public protocol OptionalType {
    
    associatedtype Wrapped
    
    /// The optional's value.
    var wrappedValue: Wrapped? { get }
    
}

extension Optional: OptionalType {

    public var wrappedValue: Wrapped? {
        return self
    }
    
}
