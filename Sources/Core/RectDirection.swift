//
//  RectDirection.swift
//  Espresso
//
//  Created by Mitch Treece on 5/26/23.
//

import Foundation

/// Representation of the various rect coordinate-space
/// directions & underlying directional points.
public struct RectDirection {
    
    /// The rect direction's start point.
    public let startPoint: CGPoint
    
    /// The rect direction's end point.
    public let endPoint: CGPoint
    
    /// Initializes a rect direction with start & end points.
    /// - parameter start: The rect direction's start point.
    /// - parameter end: The rect direction's end point.
    public init(start: CGPoint,
                end: CGPoint) {
        
        self.startPoint = start
        self.endPoint = end
        
    }
    
    /// An upwards rect direction.
    public static var up: RectDirection {
        
        return .init(
            start: .init(x: 0.5, y: 1),
            end: .init(x: 0.5, y: 0)
        )
        
    }
    
    /// A downwards rect direction.
    public static var down: RectDirection {
        
        return .init(
            start: .init(x: 0.5, y: 0),
            end: .init(x: 0.5, y: 1)
        )
        
    }
    
    /// A left rect direction.
    public static var left: RectDirection {
        
        return .init(
            start: .init(x: 1, y: 0.5),
            end: .init(x: 0, y: 0.5)
        )
        
    }
    
    /// A right rect direction.
    public static var right: RectDirection {
        
        return .init(
            start: .init(x: 0, y: 0.5),
            end: .init(x: 1, y: 0.5)
        )
        
    }
    
    /// An angled (degrees) rect direction.
    public static func angle(_ degrees: CGFloat) -> RectDirection {
        
        let end = pointForDegrees(degrees)
        let start = inversePoint(end)
        let p0 = translatePoint(start)
        let p1 = translatePoint(end)
        
        return .init(
            start: p0,
            end: p1
        )
        
    }
    
    // MARK: Private
    
    private static func pointForDegrees(_ degrees: CGFloat) -> CGPoint {
        
        let radians = degrees
            .convertAngle(to: .radian)
        
        var x = cos(radians)
        var y = sin(radians)
        
        // (x, y) is in terms of unit circle
        // Extrapolate to unit square for full vector length
        
        if abs(x) > abs(y) {
            
            // Extrapolate x to unit length
            
            x = (x > 0) ? 1 : -1
            y = x * tan(radians)
            
        }
        else {
            
            // Extrapolate y to unit length
            
            y = (y > 0) ? 1 : -1
            x = y / tan(radians)
            
        }
        
        return CGPoint(x: x, y: y)
        
    }
    
    private static func inversePoint(_ point: CGPoint) -> CGPoint {
        
        return .init(
            x: -point.x,
            y: -point.y
        )
        
    }
    
    private static func translatePoint(_ point: CGPoint) -> CGPoint {
        
        // Input point is in signed unit space: (-1, -1) to (1, 1)
        // Convert to gradient space: (0, 0) to (1, 1) with flipped Y-axis
        
        return .init(
            x: (point.x + 1) * 0.5,
            y: 1 - (point.y + 1) * 0.5
        )
        
    }
    
}
