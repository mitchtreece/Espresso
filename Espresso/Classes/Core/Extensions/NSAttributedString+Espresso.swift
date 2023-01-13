//
//  NSAttributedString+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

import UIKit

public extension NSMutableAttributedString /* Style */ {
    
    /// Adds font styling to a substring.
    /// - parameter substring: The substring.
    /// - parameter font: The font.
    /// - returns: This attributed string object.
    @discardableResult
    func addFontStyle(to substring: String,
                      font: UIFont) -> Self {
        
        guard let range = rangeOfSubstring(substring) else { return self }
                
        addAttributes(
            [.font: font],
            range: range
        )
        
        return self
        
    }
    
    /// Adds color styling to a substring.
    /// - parameter substring: The substring.
    /// - parameter color: The color.
    /// - returns: This attributed string object.
    @discardableResult
    func addColorStyle(to substring: String,
                       color: UIColor) -> Self {
        
        guard let range = rangeOfSubstring(substring) else { return self }
                
        addAttributes(
            [.foregroundColor: color],
            range: range
        )
        
        return self
        
    }
    
    /// Adds link styling to a substring.
    /// - parameter substring: The substring to apply styling to.
    /// - parameter destination: The destination path.
    /// - parameter font: The font to use for the link.
    /// - parameter color: The color to use for the link.
    /// - parameter underline: A flag indicating if the link should show an underline.
    /// - returns: This attributed string object.
    @discardableResult
    func addLinkStyle(to substring: String,
                      destination: String,
                      font: UIFont? = nil,
                      color: UIColor? = nil,
                      underline: Bool = true) -> Self {
        
        guard let range = rangeOfSubstring(substring) else { return self }
        
        if let font {
            
            addFontStyle(
                to: substring,
                font: font
            )
            
        }
        
        if let color {
            
            addColorStyle(
                to: substring,
                color: color
            )
            
        }
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.link] = destination
        
        if underline {
            
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
            attributes[.underlineColor] = color
            
        }
        
        addAttributes(
            attributes,
            range: range
        )

        return self
        
    }
    
    /// Adds centered paragraph styling to the string.
    /// - returns: This attributed string object.
    @discardableResult
    func addCenterParagraphStyle() -> Self {
        
        guard let range = rangeOfSubstring(self.string) else { return self }

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineSpacing = 4
        
        addAttributes(
            [.paragraphStyle: paragraph],
            range: range
        )

        return self

    }
    
    private func rangeOfSubstring(_ substring: String) -> NSRange? {
        
        let range = self.mutableString
            .range(of: substring)
        
        guard range.location != NSNotFound else { return nil }
        
        return range
        
    }
    
}

public extension NSMutableAttributedString /* Append */ {
    
    /// Appends a string using a font & color.
    /// - parameter string: The string to append.
    /// - parameter font: The font.
    /// - parameter color: The color.
    /// - returns: This attributed string object.
    @discardableResult
    func append(string: String,
                font: UIFont? = nil,
                color: UIColor? = nil) -> Self {

        let attributedString = NSMutableAttributedString(string: string)
        
        if let font {
            
            attributedString.addFontStyle(
                to: string,
                font: font
            )
            
        }
        
        if let color {
            
            attributedString.addColorStyle(
                to: string,
                color: color
            )
            
        }
        
        append(attributedString)
        
        return self

    }
    
}
