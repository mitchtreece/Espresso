//
//  Builder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/30/22.
//

import Foundation

/// Protocol describing something that builds something else.
public protocol Builder {
    
    /// The builder's build type.
    associatedtype BuildType
    
    /// Builds an instance of the builder's `BuildType`.
    /// - returns: A `BuildType` instance.
    func build() -> BuildType
    
}
