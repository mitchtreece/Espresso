//
//  BoolConvertible.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

/**
 `BoolConvertible` is a protocol describing the conversion to various `Bool` representations.
 */
public protocol BoolConvertible {
    
    /**
     A boolean representation.
     */
    var bool: Bool? { get }
    
    /**
     A boolean integer representation (0 _or_ 1).
     */
    var boolInt: Int? { get }
    
    /**
     A boolean string representation ("true" _or_ "false").
     */
    var boolString: String? { get }
    
}

extension Bool: BoolConvertible {
    
    public static let trueString = "true"
    public static let falseString = "false"
    
    public var bool: Bool? {
        return self
    }
    
    public var boolInt: Int? {
        return self ? 1 : 0
    }
    
    public var boolString: String? {
        return self ? Bool.trueString : Bool.falseString
    }
    
}

extension Int: BoolConvertible {
    
    public var bool: Bool? {
        return (self <= 0) ? false : true
    }
    
    public var boolInt: Int? {
        return (self <= 0) ? 0 : 1
    }
    
    public var boolString: String? {
        return (self <= 0) ? "false" : "true"
    }
    
}

extension String: BoolConvertible {
    
    public var bool: Bool? {
        
        guard let intValue = self.boolInt else { return nil }
        
        switch intValue {
        case 0: return false
        case 1: return true
        default: return nil
        }
        
    }
    
    public var boolInt: Int? {
        
        guard let stringValue = self.boolString else { return nil }
        
        switch stringValue {
        case Bool.trueString: return 1
        case Bool.falseString: return 0
        default: return nil
        }
        
    }
    
    public var boolString: String? {
        
        let value = self.lowercased()
        
        if value == Bool.trueString || value == "1" {
            return Bool.trueString
        }
        else if value == Bool.falseString || value == "0" {
            return Bool.falseString
        }
        
        return nil
        
    }
    
}
