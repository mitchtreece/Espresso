//
//  AsyncBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/30/22.
//

import Foundation

/// Protocol describing something that builds something else asynchronously.
public protocol AsyncBuilder {
    
    /// The builder's build type.
    associatedtype BuildType
    
    /// Builds an instance of the builder's build type.
    /// - returns: A `BuildType` instance.
    func build() async -> BuildType
    
}
