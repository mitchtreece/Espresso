//
//  URLRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/13/23.
//

import Foundation

/// Protocol describing something that can be represented as a `URL`.
public protocol URLRepresentable {
    
    /// A url representation.
    func asUrl() -> URL?
        
}

public extension URLRepresentable {
    
    /// The url's query parameter dictionary, if any.
    var urlQueryParameters: [String: String]? {
        
        var params = [String: String]()
        
        self.asUrl()?
            .query?
            .components(separatedBy: "&").forEach { (component) in
            
                let pair = component
                    .components(separatedBy: "=")
                
                if pair.count == 2 {
                    
                    let key = pair[0]
                    
                    let value = pair[1]
                        .replacingOccurrences(of: "+", with: " ")
                        .removingPercentEncoding ?? pair[1]
                    
                    params[key] = value
                    
                }
                
            }
        
        return (params.count > 0) ? params : nil
        
    }
    
    /// A url string representation.
    func asUrlString() -> String? {
        
        return asUrl()?
            .absoluteString
        
    }
    
}

extension URL: URLRepresentable {
    
    public func asUrl() -> URL? {
        return self
    }
    
}

extension String: URLRepresentable {
    
    public func asUrl() -> URL? {
        
        if let url = URL(string: self) {
            return url
        }
        
        var characters = CharacterSet()
        characters.formUnion(.urlHostAllowed)
        characters.formUnion(.urlPathAllowed)
        characters.formUnion(.urlQueryAllowed)
        characters.formUnion(.urlFragmentAllowed)
        
        return self
            .addingPercentEncoding(withAllowedCharacters: characters)
            .flatMap { URL(string: $0) }
        
    }
    
}
