//
//  UIVerticalEdgeInsets.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// A set of vertical edge insets.
public struct VerticalEdgeInsets {
    
    /// A zero-based vertical edge inset.
    public static var zero: VerticalEdgeInsets {
        return .init(top: 0, bottom: 0)
    }
    
    /// The top edge inset.
    public var top: CGFloat
    
    /// The bottom edge inset.
    public var bottom: CGFloat
    
    /// Initializes `VerticalEdgeInsets` with top & bottom values.
    /// - parameter top: The left value.
    /// - parameter bottom: The right value.
    public init(top: CGFloat,
                bottom: CGFloat) {
        
        self.top = top
        self.bottom = bottom
        
    }
    
    /// Initializes `VerticalEdgeInsets` with a value.
    ///
    /// - paramter value: The value.
    public init(_ value: CGFloat) {
        
        self.init(
            top: value,
            bottom: value
        )
        
    }
    
    /// Sets the inset's top value.
    ///
    /// - parameter value: The new value.
    /// - returns: This insets object.
    @discardableResult
    public mutating func top(_ value: CGFloat) -> Self {
        
        self.top = value
        return self
        
    }
    
    /// Sets the inset's bottom value.
    ///
    /// - parameter value: The new value.
    /// - returns: This insets object.
    @discardableResult
    public mutating func bottom(_ value: CGFloat) -> Self {
        
        self.bottom = value
        return self
        
    }
    
}
