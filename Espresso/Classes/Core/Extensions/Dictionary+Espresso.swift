//
//  Dictionary+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 3/14/19.
//

import Foundation

public extension Dictionary where Value: OptionalType {
    
    /// Creates a new non-optional dictionary by removing key/value pairs with `nil` values.
    /// - returns: A new non-optional dictionary.
    ///
    ///     let optionalMap: [String: Int?] = [
    ///         "one": 1,
    ///         "two": nil,
    ///         "three": 3
    ///     ]
    ///
    ///     let concreteMap: [String: Int] = optionalMap.compact()
    ///     print(concreteMap) => "["one": 1, "three": 3]"
    func compact() -> [Key: Value.Wrapped] {
        return compactMapValues { $0 as? Value.Wrapped }
    }
    
}
