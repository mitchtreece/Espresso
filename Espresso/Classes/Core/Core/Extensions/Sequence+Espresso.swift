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

public extension Sequence where Element: BooleanRepresentable {
    
    /// Returns a boolean value indicating whether
    /// all elements are truthy.
    ///
    /// - returns: `true` if the sequence contains only truthy elements; otherwise, `false`.
    func allTrue() -> Bool {
        return allSatisfy { $0.asBool() }
    }
    
    /// Returns a boolean value indicating whether
    /// all elements are falsy.
    ///
    /// - returns: `true` if the sequence contains only falsy elements; otherwise, `false`.
    func allFalse() -> Bool {
        return allSatisfy { !$0.asBool() }
    }
    
    /// Returns a boolean value indicating whether
    /// any elements are truthy.
    ///
    /// - returns: `true` if the sequence contains any truthy elements; otherwise, `false`.
    func anyTrue() -> Bool {
        return anySatisfy { $0.asBool() }
    }
    
    /// Returns a boolean value indicating whether
    /// any elements are falsy.
    ///
    /// - returns: `true` if the sequence contains any falsy elements; otherwise, `false`.
    func anyFalse() -> Bool {
        return anySatisfy { !$0.asBool() }
    }
    
}
