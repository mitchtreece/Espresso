//
//  Clampable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/9/20.
//

import Foundation

/// Protocol describing the attributes of something that can be clamped.
public protocol Clampable {
    
    /// Clamps between minimum & maximum values.
    /// - Parameter min: The minimum value.
    /// - Parameter max: The maximum value.
    /// - Returns: The clamped value.
    func clamp(min: Self, max: Self) -> Self
    
}

/// Clamps a value between minimum & maximum values.
/// - Parameter value: The value to clamp.
/// - Parameter min: The minimum value.
/// - Parameter max: The maximum value.
/// - Returns: The clamped value.
public func clamp<T: Clampable>(_ value: T, min: T, max: T) -> T {
    
    return value.clamp(
        min: min,
        max: max
    )
    
}

extension Double: Clampable {

    public func clamp(min: Double, max: Double) -> Double {
        return Swift.min(max, Swift.max(min, self))
    }

}

extension Float: Clampable {

    public func clamp(min: Float, max: Float) -> Float {
        return Swift.min(max, Swift.max(min, self))
    }

}

extension CGFloat: Clampable {

    public func clamp(min: CGFloat, max: CGFloat) -> CGFloat {
        return Swift.min(max, Swift.max(min, self))
    }

}

extension Int: Clampable {
    
    public func clamp(min: Int, max: Int) -> Int {
        return Swift.min(max, Swift.max(min, self))
    }

}
