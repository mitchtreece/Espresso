//
//  Binding+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/22/22.
//

import SwiftUI

public extension Binding {
    
    /// Creates a binding with a constant value.
    /// - parameter value: A constant value.
    /// - returns: A binding over a constant value.
    static func value(_ value: Value) -> Binding<Value> {
        return .constant(value)
    }
    
}
