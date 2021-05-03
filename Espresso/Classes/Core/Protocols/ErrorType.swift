//
//  ErrorType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that can be represented as an `Error`.
public protocol ErrorType {
    
    /// An error representation.
    var errorValue: Error { get }
    
}

extension NSError: ErrorType {
    
    public var errorValue: Error {
        return self as Error
    }
    
}

extension String: ErrorType {
    
    public var errorValue: Error {
                
        return NSError(
            domain: Bundle.main.bundleIdentifier ?? "com.mitchtreece.Espresso",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: self]
        )
        .errorValue
        
    }
    
}
