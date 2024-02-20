//
//  Dictionary+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 3/14/19.
//

import Foundation

public extension Dictionary where Value: OptionalType /* Compact */ {
    
    /// Creates a new dictionary by removing key/value pairs with `nil` values.
    /// - returns: A new concrete-value dictionary.
    ///
    ///     let dictionary: [String: Int?] = [
    ///         "one": 1,
    ///         "two": nil,
    ///         "three": 3
    ///     ]
    ///
    ///     let compactDictionary: [String: Int] = dictionary.compact()
    ///     print(compactDictionary) => "["one": 1, "three": 3]"
    func compact() -> [Key: Value.Wrapped] {
        return compactMapValues { $0 as? Value.Wrapped }
    }
    
}

public extension Dictionary /* Merge */ {
    
    /// Creates a dictionary by merging the given dictionary
    /// into this dictionary, using the other dictionary's values
    /// for duplicate keys.
    ///
    /// ```
    /// let x = ["one": 1, "two": 2, "three": 3]
    /// let y = ["one": 3, "three": 1, "four": 4]
    ///
    /// let z = x.mergingLatest(y)
    /// z => ["one", 3, "two": 2, "three": 1, "four": 4]
    /// ```
    func mergingLatest(_ other: [Key: Value]) -> [Key: Value] {
        
        return merging(other) { _, otherValue in
            return otherValue
        }
        
    }
    
}
