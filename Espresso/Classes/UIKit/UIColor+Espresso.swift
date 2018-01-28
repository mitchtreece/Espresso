//
//  UIColor+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/5/18.
//

import UIKit

// MARK: Hex

public extension UIColor {
    
    public convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        let r, g, b, a: UInt32

        Scanner(string: hex).scanHexInt32(&int)
        
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17) // RGB (12-bit)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF) // RGB (24-bit)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF) // ARGB (32-bit)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(red: (CGFloat(r) / 255),
                  green: (CGFloat(g) / 255),
                  blue: (CGFloat(b) / 255),
                  alpha: (CGFloat(a) / 255))
        
    }

}
