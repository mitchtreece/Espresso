//
//  Nonce.swift
//  Espresso
//
//  Created by Mitch Treece on 3/10/20.
//

import Foundation

/// Class that represents a random nonce.
public class Nonce {
    
    private enum Error: Swift.Error {
        
        case invalidLength
        case sec(OSStatus)
        
    }
    
    /// The nonce length.
    public let length: Int
    
    /// The nonce data representation.
    public private(set) var data: Data
    
    /// The nonce base64 string representation.
    public var string: String {
        return String(data: self.data, encoding: .utf8)!
    }
    
    /// Initializes a `Nonce` with a given length.
    /// - parameter length: The nonce data length; _defaults to 32_.
    public init?(length: Int = 32) {
        
        guard let data = String(randomWithLength: length)
            .data(using: .utf8) else { return nil }
        
        self.data = data
        self.length = length
        
    }

    /// Creates a hashed hex nonce string using a given digest.
    /// - parameter digest: The crypto digest to use; _defaults to sha256_.
    /// - returns: A hashed hex nonce string.
    public func hashed(using digest: CryptoDigest = .sha256) -> String? {
        return self.data.hashed(using: digest)
    }
    
}
