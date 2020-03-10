//
//  Nonce.swift
//  Espresso
//
//  Created by Mitch Treece on 3/10/20.
//

import Foundation

/// Class that represents a set of random nonce data.
public class Nonce {
    
    private enum SecError: Error {
        case code(OSStatus)
    }
    
    /// The nonce data length.
    public let length: Int
    
    /// The nonce data.
    public private(set) var data: Data!
    
    /// The nonce data's base64 string representation.
    public var string: String {
        return self.data.base64EncodedString()
    }
    
    /// Initializes a `Nonce` with a given length.
    /// - Parameter length: The nonce data length; _defaults to 32_.
    public init?(length: Int = 32) {
        
        self.length = length
        
        do {
            try generate()
        }
        catch {
            return nil
        }
        
    }
    
    private func generate() throws {
        
        var data = Data(count: self.length)
        
        let result = data.withUnsafeMutableBytes {
            
            SecRandomCopyBytes(
                kSecRandomDefault,
                self.length,
                $0.baseAddress!
            )
            
        }
        
        if result == errSecSuccess {
            self.data = data
            return
        }
        
        throw SecError.code(result)
        
    }
    
}
