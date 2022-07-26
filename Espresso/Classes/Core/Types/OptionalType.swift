//
//  OptionalType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that can be represented as an `Optional`.
public protocol OptionalType {
    
    associatedtype Wrapped
    
    /// The optional's type representation.
    var optionalType: Any.Type { get }
    
    /// An optional representation.
    var optionalValue: Wrapped? { get }
    
}

extension Optional: OptionalType {

    public var optionalType: Any.Type {
        return Wrapped.self
    }
    
    public var optionalValue: Wrapped? {
        return self
    }
    
}
