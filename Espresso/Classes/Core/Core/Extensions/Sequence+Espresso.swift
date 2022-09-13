//
//  Sequence+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 9/12/22.
//

import Foundation

public extension Sequence /* Any Satisfy */ {
    
    /// Returns a boolean value indicating whether any
    /// element of a sequence satisfies a given predicate.
    ///
    /// - parameter predicate: A closure that takes an element of the sequence as its argument
    /// and returns a boolean value that indicates whether the passed element satisfies a condition.
    /// - returns: `true` if the sequence contains any element that satisfies the predicate; otherwise, `false`.
    func anySatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try contains(where: predicate)
    }

}
