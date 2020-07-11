//
//  BoolConvertible.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

/// Protocol describing a type that can be represented as a `bool`.
public protocol BoolConvertible {
    
    /// A `bool` value representation.
    var boolValue: Bool { get }
    
}

extension Bool: BoolConvertible {
    
    public var boolValue: Bool {
        return self
    }
    
    /// An `int` value representation.
    public var intValue: Int {
        return self ? 1 : 0
    }
    
    /// A `String` value representation.
    public var stringValue: String {
        return self ? "true" : "false"
    }
    
}

extension Int: BoolConvertible {
    
    public var boolValue: Bool {
        return (self >= 1) ? true : false
    }
    
}

extension String: BoolConvertible {
    
    public var boolValue: Bool {
        
        if self == "true" || self == "0" {
            return true
        }
        
        return false
        
    }
    
}
