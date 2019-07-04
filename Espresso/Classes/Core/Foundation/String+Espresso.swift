//
//  String+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public extension String /* Size */ {
    
    /**
     Calculates the display size for the string using a constraint & attributes.
     
     - Parameter size: The constrained size.
     - Parameter attributes: The string attributes to use while calculating the size.
     - Returns: The string's display size.
     */
    func size(constrainedTo size: CGSize, attributes: [NSAttributedString.Key: Any]?) -> CGSize {
        
        return (self as NSString).boundingRect(with: size,
                                               options: [.usesLineFragmentOrigin],
                                               attributes: attributes,
                                               context: nil).size
        
    }
    
    /**
     Calculates the display width for the string using a constrained height & attributes.
     
     - Parameter height: The constrained height.
     - Parameter attributes: The string attributes to use while calculating the width.
     - Returns: The string's display width.
     */
    func width(forHeight height: CGFloat, attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        let constraint = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        return size(constrainedTo: constraint, attributes: attributes).width
        
    }
    
    /**
     Calculates the display width for the string using a constrained height & font.
     
     - Parameter height: The constrained height.
     - Parameter font: The font to use while calculating the width.
     - Returns: The string's display width.
     */
    func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
        return width(forHeight: height, attributes: [.font: font])
    }
    
    /**
     Calculates the display height for the string using a constrained width & attributes.
     
     - Parameter width: The constrained width.
     - Parameter attributes: The string attributes to use while calculating the height.
     - Returns: The string's display height.
     */
    func height(forWidth width: CGFloat, attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        let constraint = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return size(constrainedTo: constraint, attributes: attributes).height
        
    }
    
    /**
     Calculates the display height for the string using a constrained width & font.
     
     - Parameter width: The constrained width.
     - Parameter font: The font to use while calculating the height.
     - Returns: The string's display height.
     */
    func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        return height(forWidth: width, attributes: [.font: font])
    }
    
}

public extension String /* Tokens */ {
    
    /**
     Creates a new string by replacing all occurrences of a **\<token\>** with another string.
     
     - Parameter token: The token to replace.
     - Parameter string: The replacement string.
     - Returns: A new string with all token occurrences replaced.
     */
    func replacing(token: String, with string: String) -> String {
        
        let _token = (token.first == "<" && token.last == ">") ? token : "<\(token)>"
        return self.replacingOccurrences(of: _token, with: string)
        
    }
    
    /**
     Creates a new string by replacing all occurrences of **\<token\>'s** with their corresponding replacements.
     
     - Parameter tokens: A dictionary map of \<token\>'s to replacement strings.
     - Returns: A new string with all token occurrences replaced.
     */
    func replacing(tokens: [String: String]) -> String {
        
        var string = self
        
        for (key, value) in tokens {
            
            let token = (key.first == "<" && key.last == ">") ? key : "<\(key)>"
            string = string.replacing(token: token, with: value)
            
        }
        
        return string
        
    }
    
}
