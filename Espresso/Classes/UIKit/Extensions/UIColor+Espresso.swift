//
//  UIColor+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/5/18.
//

import UIKit

public extension UIColor /* Random */ {
    
    /// Creates a new color with random r, g, b values & a specified alpha.
    ///- Parameter alpha: The color's alpha value; _defaults to 1_.
    /// - Returns: A random color.
    static func random(alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
    
}

public extension UIColor /* Hex */ {
    
    /// Initializes a new color from a hex code.
    /// - Parameter hex: The hex code string.
    convenience init(hex: String) {
        
        let _hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        let r, g, b, a: UInt32

        Scanner(string: _hex).scanHexInt32(&int)
        
        switch _hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17) // RGB (12-bit)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF) // RGB (24-bit)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF) // ARGB (32-bit)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            red: (CGFloat(r) / 255),
            green: (CGFloat(g) / 255),
            blue: (CGFloat(b) / 255),
            alpha: (CGFloat(a) / 255)
        )
        
    }
    
    /// Initializes a new color from a hex code.
    /// - Parameter hex: The hex code string.
    /// - Returns: A new hex-based `UIColor`.
    static func hex(_ hex: String) -> UIColor {
        return UIColor(hex: hex)
    }

}
