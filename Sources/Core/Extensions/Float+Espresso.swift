//
//  Float+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public extension Float {
    
    /// Converts an angle value to a different angle unit.
    /// - Parameter unit: The angle unit to convert to.
    func convertAngle(to unit: AngleUnit) -> Float {
        
        switch unit {
        case .degree:
            
            // Radians -> Degrees
            return (self * 180 / .pi)
            
        case .radian:
            
            // Degrees -> Radians
            return (self * .pi / 180)
            
        }
        
    }
    
}

public extension CGFloat {
    
    /// Converts an angle value to a different angle unit.
    /// - Parameter unit: The angle unit to convert to.
    func convertAngle(to unit: AngleUnit) -> CGFloat {
        return CGFloat(Float(self).convertAngle(to: unit))
    }
    
}
