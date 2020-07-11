//
//  StringIdentifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/27/18.
//

import UIKit

/// Protocol that describes a way to statically identify an object using a string.
public protocol StringIdentifiable {
    
    /// The string identifier.
    static var stringId: String { get }
    
}

public extension StringIdentifiable {
    
    static var stringId: String {
        return String(describing: self)
    }
    
}
