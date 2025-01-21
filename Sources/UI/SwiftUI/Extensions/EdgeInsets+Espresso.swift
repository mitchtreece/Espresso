//
//  EdgeInsets+Espresso.swift
//  Espresso
//
//  Created by Mitch on 1/21/25.
//

#if canImport(UIKit)

import SwiftUI
import UIKit

public extension EdgeInsets /* Zero */ {
    
    static var zero: EdgeInsets = .init(
        top: 0,
        leading: 0,
        bottom: 0,
        trailing: 0
    )
    
}

public extension EdgeInsets /* Initializers */ {
    
    /// Initializes `EdgeInsets` with a value.
    /// - parameter value: The value.
    init(_ value: CGFloat) {
        
        self.init(
            top: value,
            leading: value,
            bottom: value,
            trailing: value
        )
        
    }
    
    /// Initializes `EdgeInsets` with horizontal & vertical values.
    /// - parameter horizontal: The horizontal value.
    /// - parameter vertical: The vertical value.
    init(horizontal: CGFloat,
         vertical: CGFloat) {
        
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
        
    }
    
    /// Initializes `EdgeInsets` with a top value.
    /// - parameter top: The top value.
    init(top: CGFloat) {
        
        self.init(
            top: top,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
    }
    
    /// Initializes `EdgeInsets` with a leading value.
    /// - parameter leading: The leading value.
    init(leading: CGFloat) {
        
        self.init(
            top: 0,
            leading: leading,
            bottom: 0,
            trailing: 0
        )
        
    }
    
    /// Initializes `EdgeInsets` with a bottom value.
    /// - parameter bottom: The bottom value.
    init(bottom: CGFloat) {
        
        self.init(
            top: 0,
            leading: 0,
            bottom: bottom,
            trailing: 0
        )
        
    }
    
    /// Initializes `EdgeInsets` with a trailing value.
    /// - parameter trailing: The trailing value.
    init(trailing: CGFloat) {
        
        self.init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: trailing
        )
        
    }
    
}

public extension EdgeInsets /* Builders */ {
    
    /// Sets the edge-inset's top value.
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func top(_ value: CGFloat) -> Self {
        
        self.top = value
        return self
        
    }
    
    /// Sets the edge-inset's leading value.
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func leading(_ value: CGFloat) -> Self {
        
        self.leading = value
        return self
        
    }
    
    /// Sets the edge-inset's bottom value.
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func bottom(_ value: CGFloat) -> Self {
        
        self.bottom = value
        return self
        
    }
    
    /// Sets the edge-inset's trailing value.
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func trailing(_ value: CGFloat) -> Self {
        
        self.trailing = value
        return self
        
    }
    
    /// Sets the edge-inset's leading & trailing values.
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func horizontal(_ value: CGFloat) -> Self {
        
        self.leading = value
        self.trailing = value
        return self
        
    }
    
    /// Sets the edge-inset's top & bottom values.
    /// - parameter value: The new value.
    /// - returns: This edge-insets object.
    @discardableResult
    mutating func vertical(_ value: CGFloat) -> Self {
        
        self.top = value
        self.bottom = value
        return self
        
    }
    
}

public extension EdgeInsets /* Representation */ {
    
    /// A UIKit `UIEdgeInsets` representation.
    func asUIEdgeInsets() -> UIEdgeInsets {
        
        return .init(
            top: self.top,
            left: self.leading,
            bottom: self.bottom,
            right: self.trailing
        )
        
    }
    
    /// A `HorizontalEdgeInsets` representation.
    func asHorizontalEdgeInsets() -> HorizontalEdgeInsets {
        
        return .init(
            left: self.leading,
            right: self.trailing
        )
        
    }
    
    /// A `VerticalEdgeInsets` representation.
    func asVerticalEdgeInsets() -> VerticalEdgeInsets {
        
        return .init(
            top: self.top,
            bottom: self.bottom
        )
        
    }
    
}

#endif
