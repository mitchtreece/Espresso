//
//  None.swift
//  Espresso
//
//  Created by Mitch on 1/20/25.
//

import Foundation

/// A `nil` representation of an `Any` type.
public typealias AnyNone = None<Any>

/// A `nil` representation over a type.
public struct None<T> {
    
    public static var value: T? { nil }
    
    private init() {}
    
}
