//
//  Mockable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

/// Protocol that describes something that can be represented using mock data.
public protocol Mockable {

    /// Creates a mock of this type.
    static func mock() -> Self
    
    /// Creates a mock-array of this type.
    static func mocks() -> [Self]

}
