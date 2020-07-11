//
//  ErrorConvertible.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

/// Protocol describing a type that can be represented as an `Error`.
public protocol ErrorConvertible {
    
    /// An `Error` value representation.
    var errorValue: Error { get }
    
}

extension NSError: ErrorConvertible {
    
    public var errorValue: Error {
        return self as Error
    }
        
}

extension String: ErrorConvertible {
    
    public var errorValue: Error {
        
        let domain = Bundle.main.bundleIdentifier ?? "com.mitchtreece.Espresso"
        
        return NSError(
            domain: domain,
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: self]
        )
        .errorValue
        
    }
    
}
