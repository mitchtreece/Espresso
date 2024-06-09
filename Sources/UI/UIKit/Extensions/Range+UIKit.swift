//
//  Range+UIKit.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/23.
//

import CoreFoundation

// MARK: Range (0..<100)

public extension Range where Bound == CGFloat {
    
    /// Lerps to a value in the range, given a progress value.
    ///
    /// - parameter progress: The lerp progress (0.0 - 1.0).
    /// - returns: The lerped value at the given progress.
    func lerpedValue(progress: CGFloat) -> CGFloat {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return CGFloat((min..<max)
            .lerpedValue(progress: Float(progress)))
        
    }
    
    /// Gets the lerp progress in the range, given a value.
    ///
    /// - parameter value: The value to find progress for.
    /// - returns: The progress for the given value (0.0 - 1.0).
    func lerpedProgress(value: CGFloat) -> CGFloat {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return CGFloat((min..<max)
            .lerpedProgress(value: Float(value)))
        
    }
    
}

// MARK: ClosedRange (0...100)

public extension ClosedRange where Bound == CGFloat {
    
    /// Lerps to a value in the range, given a progress value.
    ///
    /// - parameter progress: The lerp progress (0.0 - 1.0).
    /// - returns: The lerped value at the given progress.
    func lerpedValue(progress: CGFloat) -> CGFloat {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return CGFloat((min...max)
            .lerpedValue(progress: Float(progress)))
        
    }
    
    /// Gets the lerp progress in the range, given a value.
    ///
    /// - parameter value: The value to find progress for.
    /// - returns: The progress for the given value (0.0 - 1.0).
    func lerpedProgress(value: CGFloat) -> CGFloat {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return CGFloat((min...max)
            .lerpedProgress(value: Float(value)))
        
    }
    
}
