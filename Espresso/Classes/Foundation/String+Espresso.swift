//
//  String+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public extension String /* Height */ {
    
    /**
     Calculates the display height for the string using a constrained width & attributes.
     
     - Parameter width: The constrained width.
     - Parameter attributes: The string attributes to use while calculating the height.
     - Returns: The string's display height.
     */
    func height(forWidth width: CGFloat, attributes: [NSAttributedStringKey: Any]?) -> CGFloat {
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        return (self as NSString).boundingRect(with: size,
                                               options: [.usesLineFragmentOrigin],
                                               attributes: attributes,
                                               context: nil).size.height
        
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
    
    public typealias Token = String
    
    /**
     Creates a new string by replacing all occurrences of a **\<token\>** with another string.
     
     - Parameter token: The token to replace.
     - Parameter string: The replacement string.
     - Returns: A new string with all token occurrences replaced.
     */
    public func replacing(token: Token, with string: String) -> String {
        
        let _token = (token.first == "<" && token.last == ">") ? token : "<\(token)>"
        return self.replacingOccurrences(of: _token, with: string)
        
    }
    
    /**
     Creates a new string by replacing all occurrences of **\<token\>'s** with their corresponding replacements.
     
     - Parameter tokens: A dictionary map of \<token\>'s to replacement strings.
     - Returns: A new string with all token occurrences replaced.
     */
    public func replacing(tokens: [Token: String]) -> String {
        
        var string = self
        
        for (key, value) in tokens {
            
            let token = (key.first == "<" && key.last == ">") ? key : "<\(key)>"
            string = string.replacing(token: token, with: value)
            
        }
        
        return string
        
    }
    
}
