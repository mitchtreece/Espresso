//
//  Actor+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 11/18/24.
//

import Foundation

public extension Actor {
    
    /// Performs a closure within the actor's isolation context.
    ///
    /// - parameter closure: The closure to perform.
    func isolated<T: Sendable>(_ closure: (isolated Self) -> T) -> T {
        return closure(self)
    }
    
}
