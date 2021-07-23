//
//  UIVerticalEdgeInsets.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

/// A set of vertical edge insets.
public struct UIVerticalEdgeInsets {
    
    /// A zero-based vertical edge inset.
    public static var zero: UIVerticalEdgeInsets {
        return UIVerticalEdgeInsets(top: 0, bottom: 0)
    }
    
    /// The top edge inset.
    public var top: CGFloat
    
    /// The bottom edge inset.
    public var bottom: CGFloat
    
    /// Initializes `UIVerticalEdgeInsets` with top & bottom values.
    /// - parameter top: The left value.
    /// - parameter bottom: The right value.
    public init(top: CGFloat,
                bottom: CGFloat) {
        
        self.top = top
        self.bottom = bottom
        
    }
    
    /// A traditional `UIEdgeInsets` representation.
    public var edgeInsets: UIEdgeInsets {
        
        return UIEdgeInsets(
            top: self.top,
            left: 0,
            bottom: self.bottom,
            right: 0
        )
        
    }
    
}
