//
//  Buildable.swift
//  Espresso
//
//  Created by Mitch Treece on 4/17/23.
//

import Foundation

/// Protocol describing something that can be
/// built & setup using a context object.
public protocol Buildable {
    
    /// The object's build context.
    associatedtype BuildContext: Context
    
    init()
    
    /// Configures the object using a context object.
    /// - parameter ctx: The build context.
    /// - returns: This buildable object.
    @discardableResult
    func setup(ctx: BuildContext) -> Self
    
}

public extension Buildable {
    
    /// Instantiates and returns an instance of this
    /// buildable type using a context object.
    /// - parameter ctx: The build context.
    /// - returns: A buildable object.
    static func build(ctx: BuildContext) -> Self {
        
        return Self()
            .setup(ctx: ctx)
                
    }
    
}
