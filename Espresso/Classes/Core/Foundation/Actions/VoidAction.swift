//
//  VoidAction.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// An action that is executed without any data.
public class VoidAction {
        
    private let block: ()->()
    
    /// Initializes an action using a given execution block.
    /// - Parameter block: The action's execution block.
    public init(_ block: @escaping ()->()) {
        self.block = block
    }
    
    public func run() {
        self.block()
    }
    
}
