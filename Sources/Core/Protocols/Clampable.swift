//
//  Clampable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/9/20.
//

import Foundation

/// Clamps the receiver from a minimum, through a maximum value.
/// - parameter value: The value to clamp.
/// - parameter min: The minimum value.
/// - parameter max: The maximum value.
/// - returns: The clamped value.
public func clamped<T: Clampable>(_ value: T, min: T, max: T) -> T {
    
    return value.clamped(
        min: min,
        max: max
    )
    
}

/// Clamps the receiver from minimum, up-to maximum values in a range.
/// - parameter value: The value to clamp.
/// - parameter range: The range to clamp the value within.
/// - returns: The clamped value.
public func clamped<T: Clampable>(_ value: T, range: Range<T>) -> T {
    return value.clamped(range)
}

/// Clamps the receiver from minimum, through maximum values in a range.
/// - parameter value: The value to clamp.
/// - parameter range: The range to clamp the value through.
/// - returns: The clamped value.
public func clamped<T: Clampable>(_ value: T, range: ClosedRange<T>) -> T {
    return value.clamped(range)
}

/// Protocol describing the attributes of something
/// that can be clamped to / within a range.
public protocol Clampable: Comparable {
    
    /// Clamps the receiver from a minimum, through a maximum value.
    /// - parameter min: The minimum value.
    /// - parameter max: The maximum value.
    /// - returns: The clamped value.
    func clamped(min: Self, max: Self) -> Self
    
}

public extension Clampable {
    
    /// Clamps the receiver from minimum, up-to maximum values in a range.
    /// - parameter range: The range to clamp the value within.
    /// - returns: The clamped value.
    func clamped(_ range: Range<Self>) -> Self {
        
        return clamped(
            min: range.lowerBound,
            max: range.upperBound
        )
        
    }
    
    /// Clamps the receiver from minimum, through maximum values in a range.
    /// - parameter range: The range to clamp the value through.
    /// - returns: The clamped value.
    func clamped(_ range: ClosedRange<Self>) -> Self {
        
        return clamped(
            min: range.lowerBound,
            max: range.upperBound
        )
        
    }
    
}

extension Double: Clampable {

    public func clamped(min: Double, max: Double) -> Double {
        return Swift.min(max, Swift.max(min, self))
    }

}

extension Float: Clampable {

    public func clamped(min: Float, max: Float) -> Float {
        return Swift.min(max, Swift.max(min, self))
    }

}

extension CGFloat: Clampable {

    public func clamped(min: CGFloat, max: CGFloat) -> CGFloat {
        return Swift.min(max, Swift.max(min, self))
    }

}

extension Int: Clampable {
    
    public func clamped(min: Int, max: Int) -> Int {
        return Swift.min(max, Swift.max(min, self))
    }

}
