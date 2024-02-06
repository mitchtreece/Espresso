//
//  Range+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/23.
//

import Foundation

// MARK: Range (0..<100)

public extension Range where Bound == Float {
    
    /// Lerps to a value in the range, given a progress value.
    ///
    /// - parameter progress: The lerp progress (0.0 - 1.0).
    /// - returns: The lerped value at the given progress.
    func lerpedValue(progress: Float) -> Float {
        
        let min = self.lowerBound
        let max = self.upperBound
        
        return (min + (max - min) * progress)
        
    }
    
    /// Gets the lerp progress in the range, given a value.
    ///
    /// - parameter value: The value to find progress for.
    /// - returns: The progress for the given value (0.0 - 1.0).
    func lerpedProgress(value: Float) -> Float {
        
        let min = self.lowerBound
        let max = self.upperBound
                
        return ((value - min) / (max - min))
        
    }
    
}

public extension Range where Bound == Double {

    /// Lerps to a value in the range, given a progress value.
    ///
    /// - parameter progress: The lerp progress (0.0 - 1.0).
    /// - returns: The lerped value at the given progress.
    func lerpedValue(progress: Double) -> Double {

        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)

        return Double((min..<max)
            .lerpedValue(progress: Float(progress)))

    }
    
    /// Gets the lerp progress in the range, given a value.
    ///
    /// - parameter value: The value to find progress for.
    /// - returns: The progress for the given value (0.0 - 1.0).
    func lerpedProgress(value: Double) -> Double {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return Double((min..<max)
            .lerpedProgress(value: Float(value)))
        
    }

}

// MARK: ClosedRange (0...100)

public extension ClosedRange where Bound == Float {
    
    /// Lerps to a value in the range, given a progress value.
    ///
    /// - parameter progress: The lerp progress (0.0 - 1.0).
    /// - returns: The lerped value at the given progress.
    func lerpedValue(progress: Float) -> Float {
        
        let min = self.lowerBound
        let max = self.upperBound
        
        return (min + (max - min) * progress)
        
    }
    
    /// Gets the lerp progress in the range, given a value.
    ///
    /// - parameter value: The value to find progress for.
    /// - returns: The progress for the given value (0.0 - 1.0).
    func lerpedProgress(value: Float) -> Float {
        
        let min = self.lowerBound
        let max = self.upperBound
                
        return ((value - min) / (max - min))
        
    }
    
}

public extension ClosedRange where Bound == Double {

    /// Lerps to a value in the range, given a progress value.
    ///
    /// - parameter progress: The lerp progress (0.0 - 1.0).
    /// - returns: The lerped value at the given progress.
    func lerpedValue(progress: Double) -> Double {

        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)

        return Double((min...max)
            .lerpedValue(progress: Float(progress)))

    }
    
    /// Gets the lerp progress in the range, given a value.
    ///
    /// - parameter value: The value to find progress for.
    /// - returns: The progress for the given value (0.0 - 1.0).
    func lerpedProgress(value: Double) -> Double {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return Double((min...max)
            .lerpedProgress(value: Float(value)))
        
    }

}

// PartialRangeUpTo (..<100)
// PartialRangeFrom (100...)
// PartialRangeThrough (...100)
