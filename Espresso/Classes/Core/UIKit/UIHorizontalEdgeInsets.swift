//
//  UIHorizontalEdgeInsets.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

/// A set of horizontal edge insets.
public struct UIHorizontalEdgeInsets {
    
    /// A zero-based horizontal edge inset.
    public static var zero: UIHorizontalEdgeInsets {
        return UIHorizontalEdgeInsets(left: 0, right: 0)
    }
    
    /// The left edge inset.
    public var left: CGFloat
    
    /// The right edge inset.
    public var right: CGFloat
    
    /// A traditional `UIEdgeInsets` representation.
    public var edgeInsets: UIEdgeInsets {
        
        return UIEdgeInsets(
            top: 0,
            left: self.left,
            bottom: 0,
            right: self.right
        )
        
    }
    
}
