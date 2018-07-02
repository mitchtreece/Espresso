//
//  ErrorConvertible.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

/**
 Protocol describing the conversion to various `Error` representations.
 */
public protocol ErrorConvertible {
    
    /**
     An error representation.
     */
    var error: Error? { get }
    
    /**
     An error string representation.
     */
    var errorString: String? { get }
    
}

extension NSError: ErrorConvertible {
    
    public var error: Error? {
        return self as Error
    }
    
    public var errorString: String? {
        
        if let localizedDescription = self.userInfo[NSLocalizedDescriptionKey] as? String {
            return localizedDescription
        }
        
        return nil
        
    }
    
}

extension String: ErrorConvertible {
    
    public var error: Error? {
        
        let domain = Bundle.main.bundleIdentifier ?? "com.mitchtreece.Espresso"
        return NSError(domain: domain, code: -1, userInfo: [NSLocalizedDescriptionKey: self]).error
        
    }
    
    public var errorString: String? {
        return self
    }
    
}
