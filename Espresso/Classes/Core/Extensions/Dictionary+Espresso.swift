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

// NOTE: There is some weirdness when trying to compact JSON types
// that have nested JSON objects. Providing a more explicit extension
// to resolve these issues.

extension Dictionary where Key == JSON.Key, Value == JSON.Value? {

    /// Creates a new json object by removing key/value pairs with `nil` values.
    /// - returns: A new concrete-value json object.
    ///
    ///     let json: [String: Any?] = [
    ///         "one": 1,
    ///         "two": nil,
    ///         "three": 3
    ///     ]
    ///
    ///     let compactJson: JSON = json.compact()
    ///     print(compactJson) => "["one": 1, "three": 3]"
    func compact() -> JSON {
        compactMapValues { $0 }
    }

}
