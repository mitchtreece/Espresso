//
//  DataAction.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// An action that is executed with given data.
public class DataAction<T> {
    
    private let block: (T?)->()
    
    /// Initializes an action using a given execution block.
    /// - Parameter block: The action's execution block.
    public init(_ block: @escaping (T?)->()) {
        self.block = block
    }
    
    public func run(data: T?) {
        self.block(data)
    }
    
}
