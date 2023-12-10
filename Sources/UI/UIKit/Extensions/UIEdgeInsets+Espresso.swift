//
//  UIEdgeInsets+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

import UIKit

public extension UIEdgeInsets /* Initializers */ {
    
    /// Initializes `UIEdgeInsets` with a value.
    ///
    /// - parameter value: The value.
    init(_ value: CGFloat) {
        
        self.init(
            top: value,
            left: value,
            bottom: value,
            right: value
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with horizontal & vertical values.
    ///
    /// - parameter horizontal: The horizontal value.
    /// - parameter vertical: The vertical value.
    init(horizontal: CGFloat,
         vertical: CGFloat) {
        
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a top value.
    ///
    /// - parameter top: The top value.
    init(top: CGFloat) {
        
        self.init(
            top: top,
            left: 0,
            bottom: 0,
            right: 0
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a left value.
    ///
    /// - parameter left: The left value.
    init(left: CGFloat) {
        
        self.init(
            top: 0,
            left: left,
            bottom: 0,
            right: 0
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a bottom value.
    ///
    /// - parameter bottom: The bottom value.
    init(bottom: CGFloat) {
        
        self.init(
            top: 0,
            left: 0,
            bottom: bottom,
            right: 0
        )
        
    }
    
    /// Initializes `UIEdgeInsets` with a right value.
    ///
    /// - parameter top: The right value.
    init(right: CGFloat) {
        
        self.init(
            top: 0,
            left: 0,
            bottom: 0,
            right: right
        )
        
    }
    
}

public extension UIEdgeInsets /* Builders */ {
    
    /// Sets the edge-inset's top value.
    ///
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func top(_ value: CGFloat) -> Self {
        
        self.top = value
        return self
        
    }
    
    /// Sets the edge-inset's left value.
    ///
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func left(_ value: CGFloat) -> Self {
        
        self.left = value
        return self
        
    }
    
    /// Sets the edge-inset's bottom value.
    ///
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func bottom(_ value: CGFloat) -> Self {
        
        self.bottom = value
        return self
        
    }
    
    /// Sets the edge-inset's right value.
    ///
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func right(_ value: CGFloat) -> Self {
        
        self.right = value
        return self
        
    }
    
    /// Sets the edge-inset's left & right values.
    ///
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func horizontal(_ value: CGFloat) -> Self {
        
        self.left = value
        self.right = value
        
        return self
        
    }
    
    /// Sets the edge-inset's top & bottom values.
    ///
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func vertical(_ value: CGFloat) -> Self {
        
        self.top = value
        self.bottom = value
        
        return self
        
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
