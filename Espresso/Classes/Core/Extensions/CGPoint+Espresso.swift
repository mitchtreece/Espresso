//
//  CGPoint+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

import Foundation

public extension CGPoint {
    
    /// Returns the point-based difference from another point.
    /// - parameter point: The other point.
    /// - returns: The point difference.
    func difference(from point: CGPoint) -> CGPoint {

        return CGPoint(
            x: self.x - point.x,
            y: self.y - point.y
        )
        
    }
    
}
