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
    
    // The nonce's raw string representation.
    public private(set) var rawString: String = ""
    
    // The nonce's data representation.
    public var data: Data {
        return Data(self.rawString.utf8)
    }
    
    // The nonce's base64 string representation.
    public var base64String: String {
        return self.data.base64EncodedString()
    }
    
    /// Initializes a `Nonce` with a given length.
    /// - Parameter length: The nonce data length; _defaults to 32_.
    public init?(length: Int = 32) {
        
        self.length = length

        do {
            self.rawString = try generate()
        }
        catch {
            return nil
        }
        
    }

    /// Creates a hashed hex nonce string using a given digest.
    /// - Parameter digest: The crypto digest to use; _defaults to sha256_.
    /// - Returns: A hashed hex nonce string.
    public func hashed(using digest: CryptoDigest = .sha256) -> String? {
        return self.data.hashed(using: digest)
    }
    
    private func generate() throws -> String {
        
        // Adapted from:
        // https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
        
        guard self.length > 0 else { throw Error.invalidLength }
        
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        var result = ""
        var remainingLength = self.length
        
        while remainingLength > 0 {
            
            try (0..<16).map { _ -> UInt8 in
                
                var random: UInt8 = 0
                
                let secCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                
                if secCode != errSecSuccess {
                    throw Error.sec(secCode)
                }
                
                return random
                
            }
            .forEach { random in
                
                guard remainingLength != 0 else { return }
                
                if random < charset.count {
                    
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                    
                }
                
            }
                        
        }
        
        return result
        
    }
    
}
