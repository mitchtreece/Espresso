//
//  String+Digest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation

public extension String {
    
    /// Hashes the string using a crypto digest method,
    /// format, & optional RSA ASN.1 header.
    ///
    /// - parameter digest: The digest hashing method.
    /// - parameter format: The digest hash format; _defaults to hex_.
    /// - parameter rsa: The RSA type to use; _defaults to nil_.
    /// - returns: A hashed string.
    func hashed(using digest: CryptoDigest,
                format: CryptoDigest.Format = .hex,
                rsa: CryptoDigest.RSA? = nil) -> String {
        
        let data = self.data(using: .utf8) ?? Data()
        
        return data.hashed(
            using: digest,
            format: format,
            rsa: rsa
        )
        
    }
    
}
