//
//  Direction.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/21.
//

import Foundation

/// Representation of the different 2D directions.
public enum Direction {
    
    /// The upwards direction
    case up
    
    /// The downwards direction
    case down
    
    /// The left direction
    case left
    
    /// The right direction
    case right
    
    /// Returns the current direction's inverted direction.
    ///
    /// `up <-> down`
    ///
    /// `left <-> right`
    func inverted() -> Direction {
                
        switch self {
        case .up: return .down
        case .down: return .up
        case .left: return .right
        case .right: return .left
        }
        
    }
    
}
