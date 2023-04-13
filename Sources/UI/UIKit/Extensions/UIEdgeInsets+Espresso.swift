//
//  UIEdgeInsets+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

import Foundation

public extension UIEdgeInsets /* Initializers */ {
    
    /// Initializes `UIEdgeInsets` with a value.
    /// - paramter value: The value.
    init(_ value: CGFloat) {
        
        self.init(
            top: value,
            left: value,
            bottom: value,
            right: value
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a top value.
    /// - paramter top: The top value.
    init(top: CGFloat) {
        
        self.init(
            top: top,
            left: 0,
            bottom: 0,
            right: 0
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a left value.
    /// - paramter left: The left value.
    init(left: CGFloat) {
        
        self.init(
            top: 0,
            left: left,
            bottom: 0,
            right: 0
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a bottom value.
    /// - paramter bottom: The bottom value.
    init(bottom: CGFloat) {
        
        self.init(
            top: 0,
            left: 0,
            bottom: bottom,
            right: 0
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a right value.
    /// - paramter top: The right value.
    init(right: CGFloat) {
        
        self.init(
            top: 0,
            left: 0,
            bottom: 0,
            right: right
        )
        
    }
    
}

public extension UIEdgeInsets /* Horizontal & Vertical */ {
    
    /// A `HorizontalEdgeInsets` representation.
    func asHorizontalEdgeInsets() -> HorizontalEdgeInsets {
        
        return HorizontalEdgeInsets(
            left: self.left,
            right: self.right
        )
        
    }
    
    /// A `VerticalEdgeInsets` representation.
    func asVerticalEdgeInsets() -> VerticalEdgeInsets {
        
        return VerticalEdgeInsets(
            top: self.top,
            bottom: self.bottom
        )
        
    }
    
}
