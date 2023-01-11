//
//  LegacyRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

/// Protocol that describes something that can be represented as a legacy type.
public protocol LegacyRepresentable {

    associatedtype LegacyType
    
    /// Creates a legacy representation of the current type.
    ///
    /// Useful when migrating model-objects to newer versions,
    /// while still supporting api's that require legacy objects.
    ///
    ///     struct LegacyUser {
    ///
    ///         let name: String
    ///         let age: Int
    ///
    ///     }
    ///
    ///     class NewUser: LegacyRepresentable {
    ///
    ///         typealias LegacyType = OldUser
    ///
    ///         let newName: String
    ///         let newAge: Int
    ///
    ///         func asLegacy() -> OldUser {
    ///
    ///             return OldUser(
    ///                 name: self.newName,
    ///                 age: self.newAge
    ///             )
    ///
    ///         }
    ///
    ///     }
    func asLegacy() -> LegacyType

}
