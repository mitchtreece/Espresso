//
//  Lerpable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/9/20.
//

import Foundation

/// Protocol describing the attributes of something that can be linearly interpolated.
public protocol Lerpable {
    
    /// Linearly interpolate between minimum & maximum values.
    /// - Parameter min: The minimum value.
    /// - Parameter max: The maximum value.
    /// - Returns: The linearly interpolated value.
    func lerp(min: Self, max: Self) -> Self
    
    /// Inversely linear interpolate between minimum & maximum values.
    /// - parameter min: The minimum value.
    /// - Parameter max: The maximum value.
    /// - Returns: The inversely linear interpolated value.
    func ilerp(min: Self, max: Self) -> Self
    
}

/// Linearly interpolate between minimum & maximum values using a specified weight.
/// - Parameter weight: The weight value. This is usually in the range `0...1`
/// - Parameter min: The minimum value.
/// - Parameter max: The maximum value.
/// - Returns: The linearly interpolated value.
public func lerp<T: Lerpable>(_ weight: T, min: T, max: T) -> T {
    
    return weight.lerp(
        min: min,
        max: max
    )
    
}

/// Inversely linear interpolate between minimum & maximum values using a specified value.
/// - Parameter value: The value. This is usually in the range `min...max`
/// - Parameter min: The minimum value.
/// - Parameter max: The maximum value.
/// - Returns: The inversely linear interpolated weight value.
public func ilerp<T: Lerpable>(_ value: T, min: T, max: T) -> T {
    
    return value.ilerp(
        min: min,
        max: max
    )
    
}

extension Double: Lerpable {
    
    public func lerp(min: Double, max: Double) -> Double {
        return min + (self * (max - min))
    }
    
    public func ilerp(min: Double, max: Double) -> Double {
        return (self - min) / (max - min)
    }
    
}

extension Float: Lerpable {
    
    public func lerp(min: Float, max: Float) -> Float {
        return min + (self * (max - min))
    }
    
    public func ilerp(min: Float, max: Float) -> Float {
        return (self - min) / (max - min)
    }
    
}

extension CGFloat: Lerpable {
    
    public func lerp(min: CGFloat, max: CGFloat) -> CGFloat {
        return min + (self * (max - min))
    }
    
    public func ilerp(min: CGFloat, max: CGFloat) -> CGFloat {
        return (self - min) / (max - min)
    }
    
}

extension Int: Lerpable {
    
    public func lerp(min: Int, max: Int) -> Int {
        return min + (self * (max - min))
    }
    
    public func ilerp(min: Int, max: Int) -> Int {
        return (self - min) / (max - min)
    }
    
}
