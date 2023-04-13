//
//  Emptyable.swift
//  Espresso
//
//  Created by Mitch Treece on 2/14/23.
//

import Foundation

/// Protocol that describes something that can be constructed in an "empty" state.
///
/// ```
/// struct Person: Emptyable {
///
///     var name: String
///     var nickname: String?
///     var age: Int
///
///     static func empty() -> Person {
///
///         return .init(
///             name: "",
///             nickname: nil,
///             age: 0
///         )
///
///     }
///
/// }
/// ```
/// ```
/// let person = Person.empty()
/// person.name = "John Smith"
///
/// // ---------------------------
///
/// person.name     → "John Smith"
/// person.nickname → nil
/// person.age      → 0
/// ```
public protocol Emptyable {
    
    static func empty() -> Self
    
}
