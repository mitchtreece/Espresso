//
//  Edge.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// Representation of the various horizontal & vertical edges.
public enum Edge {
    
    /// Representation of the various horizontal edges.
    public enum Horizontal {
        
        /// A horizontal left edge.
        case left
        
        /// A horizontal right edge.
        case right
        
    }
    
    /// Representation of the various vertical edges.
    public enum Vertical {
        
        /// A vertical top edge.
        case top
        
        /// A vertical bottom edge.
        case bottom
        
    }
        
    /// A horizontal edge.
    case horizontal(Horizontal)
    
    
    /// A vertical edge.
    case vertical(Vertical)
    
}
