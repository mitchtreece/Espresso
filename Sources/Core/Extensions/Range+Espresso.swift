//
//  Range+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/23.
//

import Foundation

// MARK: Range (0..<100)

public extension Range where Bound == Float {
    
    /// Lerps to a value in the range, given a percentage.
    /// - parameter percentage: The lerp percentage (0.0 - 1.0).
    /// - returns: The lerped value at the given percentage.
    func lerpedValue(at percentage: Float) -> Float {
        
        let min = self.lowerBound
        let max = self.upperBound
        
        return (min + (max - min) * percentage)
        
    }
    
}

public extension Range where Bound == Double {

    /// Lerps to a value in the range, given a percentage.
    /// - parameter percentage: The lerp percentage (0.0 - 1.0).
    /// - returns: The lerped value at the given percentage.
    func lerpedValue(at percentage: Double) -> Double {

        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)

        return Double((min..<max)
            .lerpedValue(at: Float(percentage)))

    }

}

// MARK: ClosedRange (0...100)

public extension ClosedRange where Bound == Float {
    
    /// Lerps to a value in the range, given a percentage.
    /// - parameter percentage: The lerp percentage (0.0 - 1.0).
    /// - returns: The lerped value at the given percentage.
    func lerpedValue(at percentage: Float) -> Float {
        
        let min = self.lowerBound
        let max = self.upperBound
        
        return (min + (max - min) * percentage)
        
    }
    
}

public extension ClosedRange where Bound == Double {

    /// Lerps to a value in the range, given a percentage.
    /// - parameter percentage: The lerp percentage (0.0 - 1.0).
    /// - returns: The lerped value at the given percentage.
    func lerpedValue(at percentage: Double) -> Double {

        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)

        return Double((min...max)
            .lerpedValue(at: Float(percentage)))

    }

}

// PartialRangeUpTo (..<100)
// PartialRangeFrom (100...)
// PartialRangeThrough (...100)