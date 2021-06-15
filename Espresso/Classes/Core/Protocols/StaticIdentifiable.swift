//
//  StaticIdentifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/27/18.
//

import Foundation

/// Protocol that describes a way to identify an object statically.
public protocol StaticIdentifiable {
    
    /// The object's static identifier.
    static var staticIdentifier: String { get }
    
}

public extension StaticIdentifiable {
    
    static var staticIdentifier: String {
        return String(describing: self)
    }
    
}
