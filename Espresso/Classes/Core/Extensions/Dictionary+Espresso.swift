//
//  Dictionary+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 3/14/19.
//

import Foundation

public extension Dictionary where Value: OptionalType {
    
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
