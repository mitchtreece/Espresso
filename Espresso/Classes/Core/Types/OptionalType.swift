//
//  OptionalType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that *might* have a value.
public protocol OptionalType {
    
    associatedtype Wrapped
    
    /// An optional representation.
    var optionalValue: Wrapped? { get }
    
}

extension Optional: OptionalType {

    public var optionalValue: Wrapped? {
        return self
    }
    
}
