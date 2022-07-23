//
//  BooleanType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that can be represented as a `Bool`.
public protocol BooleanType {
    
    /// A boolean representation.
    var boolValue: Bool { get }
    
}

public extension BooleanType {

    var boolValue: Bool {
        return (self as? Bool) ?? false
    }
    
}

extension Bool: BooleanType {
    //
}

extension String: BooleanType {
    
    public var boolValue: Bool {
        
        let string = self.lowercased()
        
        if string == Bool.trueString || string == "1" {
            return true
        }
        
        return false
        
    }
    
}

extension Int: BooleanType {
    
    public var boolValue: Bool {
        return (self <= 0) ? false : true
    }
    
}
