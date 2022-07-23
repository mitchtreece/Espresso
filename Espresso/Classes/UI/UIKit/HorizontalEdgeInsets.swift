//
//  HorizontalEdgeInsets.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

/// A set of horizontal edge insets.
public struct HorizontalEdgeInsets {
    
    /// A zero-based horizontal edge inset.
    public static var zero: HorizontalEdgeInsets {
        return .init(left: 0, right: 0)
    }
    
    /// The left edge inset.
    public var left: CGFloat
    
    /// The right edge inset.
    public var right: CGFloat
    
    /// Initializes `HorizontalEdgeInsets` with left & right values.
    /// - parameter left: The left value.
    /// - parameter right: The right value.
    public init(left: CGFloat,
                right: CGFloat) {
        
        self.left = left
        self.right = right
        
    }
    
    /// A traditional `UIEdgeInsets` representation.
    public func asEdgeInsets() -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: 0,
            left: self.left,
            bottom: 0,
            right: self.right
        )
        
    }
    
}
