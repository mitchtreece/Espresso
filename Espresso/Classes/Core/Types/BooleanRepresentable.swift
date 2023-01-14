//
//  BooleanRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that can be represented as a `Bool`.
public protocol BooleanRepresentable {
    
    /// A boolean representation
    func asBool() -> Bool
    
}

extension Bool: BooleanRepresentable {
    
    public func asBool() -> Bool {
        return self
    }
    
}

extension Int: BooleanRepresentable {
    
    public func asBool() -> Bool {
        return (self <= 0) ? false : true
    }
    
}

extension String: BooleanRepresentable {
    
    public func asBool() -> Bool {
        
        let string = self.lowercased()
        
        if string == Bool.trueString || string == "1" {
            return true
        }
        
        return false
        
    }
    
}
