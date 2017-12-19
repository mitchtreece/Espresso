//
//  String+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

// MARK: Height

public extension String {
    
    func height(forWidth width: CGFloat, attributes: [NSAttributedStringKey: Any]?) -> CGFloat {
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return (self as NSString).boundingRect(with: size,
                                                    options: [.usesLineFragmentOrigin],
                                                    attributes: attributes,
                                                    context: nil).size.height
        
    }
    
    func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        return height(forWidth: width, attributes: [.font: font])
    }
    
}

// MARK: Tokens

public extension String {
    
    public typealias Token = String
    
    public func replacing(token: Token, with string: String) -> String {
        
        let _token = (token.first == "<" && token.last == ">") ? token : "<\(token)>"
        return self.replacingOccurrences(of: _token, with: string)
        
    }
    
    public func replacing(tokens: [Token: String]) -> String {
        
        var string = self
        
        for (key, value) in tokens {
            
            let token = (key.first == "<" && key.last == ">") ? key : "<\(key)>"
            string = string.replacing(token: token, with: value)
            
        }
        
        return string
        
    }
    
}
