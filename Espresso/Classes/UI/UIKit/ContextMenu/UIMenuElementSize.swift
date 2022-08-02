//
//  UIMenuElementSize.swift
//  Espresso
//
//  Created by Mitch Treece on 8/1/22.
//

import UIKit

/// Representation of the various sizes of `UIMenu` elements.
public enum UIMenuElementSize {
    
    /// A small menu element size.
    case small
    
    /// A medium menu element size.
    case medium
    
    /// A large menu element size.
    case large
    
    /// Gets the `UIKit` menu element size.
    @available(iOS 16, *)
    public var size: UIMenu.ElementSize {
        
        switch self {
        case .small: return .small
        case .medium: return .medium
        case .large: return .large
        }
        
    }
    
}
