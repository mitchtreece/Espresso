//
//  UIColor+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/5/18.
//

import UIKit

public extension UIColor /* Random */ {
    
    /// Creates a new color with random r, g, b values & a specified alpha.
    /// - parameter alpha: The color's alpha value; _defaults to 1_.
    /// - returns: A random color.
    static func random(alpha: CGFloat = 1) -> UIColor {
        
        return UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: alpha
        )
        
    }
    
}

public extension UIColor /* Hex */ {
    
    /// Initializes a new color from a hex code.
    /// - parameter hex: The hex code string.
    convenience init(hex: String) {
        
        let _hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        let r, g, b, a: UInt32
            
        Scanner(string: _hex)
            .scanHexInt32(&int)
                
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

}

public extension UIColor /* Interpolation */ {
    
    /// Interpolates between two colors using a given percentage.
    /// - parameter from: The source color.
    /// - parameter to: The destination color.
    /// - parameter percentage: The interpolation percentage to use.
    /// - returns: An interpolated color.
    static func lerp(from: UIColor,
                     to: UIColor,
                     percentage: CGFloat) -> UIColor {
        
        return from.lerp(
            to: to,
            percentage: percentage
        )
        
    }
    
    /// Creates a new color by interpolating from this color to a destination color using a given percentage.
    /// - parameter to: The destination color.
    /// - parameter percentage: The interpolation percentage to use.
    /// - returns: An interpolated color.
    func lerp(to color: UIColor,
              percentage: CGFloat) -> UIColor {
        
        let p = max(min(percentage, 1), 0) // 0 - 1

        guard p != 0 else { return self }
        guard p != 1 else { return color }

        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        guard getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
        guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }

        return UIColor(
            red: CGFloat(r1 + (r2 - r1) * p),
            green: CGFloat(g1 + (g2 - g1) * p),
            blue: CGFloat(b1 + (b2 - b1) * p),
            alpha: CGFloat(a1 + (a2 - a1) * p)
        )

    }
    
}
