//
//  ErrorRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that can be represented as an `Error`.
public protocol ErrorRepresentable {
    
    /// An error representation.
    func asError() -> Error
    
}

extension NSError: ErrorRepresentable {
    
    public func asError() -> Error {
        return self as Error
    }
    
}

extension String: ErrorRepresentable {
    
    public func asError() -> Error {
        
        return NSError(
            domain: Bundle.main.bundleIdentifier ?? "com.mitchtreece.Espresso",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: self]
        )
        .asError()
        
    }
    
}
