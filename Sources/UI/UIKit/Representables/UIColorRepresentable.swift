//
//  UIColorRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 12/10/23.
//

#if canImport(UIKit)

import UIKit

/// Protocol describing something that 
/// can be represented as a `UIColor`.
public protocol UIColorRepresentable {
    
    /// A `UIColor` representation.
    func asColor() -> UIColor
    
}

public extension UIColorRepresentable {
    
    func asColorHex() -> String {
                
        let components = asColor()
            .cgColor
            .components
        
        let r: CGFloat = components?[0] ?? 0
        let g: CGFloat = components?[1] ?? 0
        let b: CGFloat = components?[2] ?? 0

        let hex = String.init(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
        
        return hex
        
    }
    
}

extension UIColor: UIColorRepresentable {
    
    public func asColor() -> UIColor {
        return self
    }
    
}

extension String: UIColorRepresentable {
    
    public func asColor() -> UIColor {
        return UIColor(hex: self)
    }
    
}

#endif
