//
//  Bool+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

public extension Bool /* Strings */ {
    
    /// A "true" boolean string value.
    static let trueString = "true"
    
    /// A "false" boolean string value.
    static let falseString = "false"
    
    /// A boolean string representation; _"true"  or "false"_.
    var stringValue: String {
        return self ? Bool.trueString : Bool.falseString
    }
    
}
