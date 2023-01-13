//
//  Optional+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/25/22.
//

import Foundation

public extension Optional {
    
    /// Unwraps the optional's value _or_ throws an error if none exists.
    /// - parameter error: The error to throw if no value exists.
    /// - returns: The optional's wrapped value.
    func unwrapOrThrow(_ error: Error) throws -> Wrapped {
        
        guard let result = self else {
            throw error
        }

        return result
        
    }
    
}
