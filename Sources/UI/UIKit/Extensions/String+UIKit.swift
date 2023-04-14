//
//  String+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/23.
//

import UIKit

public extension String /* Size */ {
    
    /// Calculates the display size for the string using a constraint & attributes.
    /// - Parameter size: The constrained size.
    /// - Parameter attributes: The string attributes to use while calculating the size.
    /// - Returns: The string's display size.
    func size(constrainedTo size: CGSize,
              attributes: [NSAttributedString.Key: Any]?) -> CGSize {
        
        return (self as NSString).boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin],
            attributes: attributes,
            context: nil
        )
        .size
        
    }
    
    /// Calculates the display width for the string using a constrained height & attributes.
    /// - Parameter height: The constrained height.
    /// - Parameter attributes: The string attributes to use while calculating the width.
    /// - Returns: The string's display width.
    func width(forHeight height: CGFloat,
               attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        return size(
            constrainedTo: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
            attributes: attributes
        )
        .width
        
    }
    
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
    
    /// Calculates the display height for the string using a constrained width & attributes.
    /// - Parameter width: The constrained width.
    /// - Parameter attributes: The string attributes to use while calculating the height.
    /// - Returns: The string's display height.
    func height(forWidth width: CGFloat,
                attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        return size(
            constrainedTo: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            attributes: attributes
        )
        .height
        
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
