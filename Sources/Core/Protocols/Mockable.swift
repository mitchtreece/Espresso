//
//  Mockable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

/// Protocol that describes something that can be represented using mock data.
public protocol Mockable {

    /// Creates a mock value.
    static func mock() -> Self
    
    /// Creates a specified number of mock values.
    /// - parameter count: The requested number of mock values.
    /// - returns: An array of mock values.
    static func mocks(count: Int) -> [Self]

}

public extension Mockable {
    
    /// Creates an array of mock values.
    /// - returns: An array of mock values.
    ///
    /// By default this requests an array of 5 mock values.
    ///
    /// If you'd like a different number of values, use `mocks(count:)`
    static func mocks() -> [Self] {
        return mocks(count: 5)
    }
    
}
