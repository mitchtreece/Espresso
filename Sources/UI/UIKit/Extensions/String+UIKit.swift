//
//  String+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/23.
//

import UIKit

public extension String /* Size */ {
    
    /// Calculates the display width for the string using a constrained height & font.
    /// - parameter height: The constrained height.
    /// - parameter font: The font to use while calculating the width.
    /// - returns: The string's display width.
    func width(forHeight height: CGFloat,
               font: UIFont) -> CGFloat {
        
        return width(
            forHeight: height,
            attributes: [.font: font]
        )
        
    }
    
    /// Calculates the display height for the string using a constrained width & font.
    /// - parameter width: The constrained width.
    /// - parameter font: The font to use while calculating the height.
    /// - returns: The string's display height.
    func height(forWidth width: CGFloat,
                font: UIFont) -> CGFloat {
        
        return height(
            forWidth: width,
            attributes: [.font: font]
        )
        
    }
    
}
