//
//  Range+UIKit.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/23.
//

import UIKit

// MARK: Range (0..<100)

public extension Range where Bound == CGFloat {
    
    /// Lerps to a value in the range, given a percentage.
    /// - parameter percentage: The lerp percentage (0.0 - 1.0).
    /// - returns: The lerped value at the given percentage.
    func lerpedValue(at percentage: CGFloat) -> CGFloat {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return CGFloat((min..<max)
            .lerpedValue(at: Float(percentage)))
        
    }
    
}

// MARK: ClosedRange (0...100)

public extension ClosedRange where Bound == CGFloat {
    
    /// Lerps to a value in the range, given a percentage.
    /// - parameter percentage: The lerp percentage (0.0 - 1.0).
    /// - returns: The lerped value at the given percentage.
    func lerpedValue(at percentage: CGFloat) -> CGFloat {
        
        let min = Float(self.lowerBound)
        let max = Float(self.upperBound)
        
        return CGFloat((min...max)
            .lerpedValue(at: Float(percentage)))
        
    }
    
}
