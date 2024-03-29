//
//  HorizontalEdgeInsets.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

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
    
    /// Initializes `HorizontalEdgeInsets` with a value.
    /// - paramter value: The value.
    public init(_ value: CGFloat) {
        
        self.init(
            left: value,
            right: value
        )
        
    }
    
    /// Sets the inset's left value.
    ///
    /// - parameter value: The new value.
    /// - returns: This insets object.
    @discardableResult
    public mutating func left(_ value: CGFloat) -> Self {
        
        self.left = value
        return self
        
    }
    
    /// Sets the inset's right value.
    ///
    /// - parameter value: The new value.
    /// - returns: This insets object.
    @discardableResult
    public mutating func right(_ value: CGFloat) -> Self {
        
        self.right = value
        return self
        
    }
    
}
