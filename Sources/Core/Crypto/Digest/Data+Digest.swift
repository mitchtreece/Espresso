//
//  Data+Digest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation

public extension Data {
    
    /// Hashes the data using a crypto digest method,
    /// format, & optional RSA ASN.1 header.
    ///
    /// - parameter digest: The digest hashing method.
    /// - parameter format: The digest hash format; _defaults to hex_.
    /// - parameter rsa: The RSA type to use; _defaults to nil_.
    /// - returns: A hashed data string.
    func hashed(using digest: CryptoDigest,
                format: CryptoDigest.Format = .hex,
                rsa: CryptoDigest.RSA? = nil) -> String {
        
        var dataToHash = self
        
        if let rsa {
                        
            dataToHash = Data(rsa.asn1Header)
            dataToHash.append(self)
            
        }
        
        return digest.hash(
            data: dataToHash,
            format: format
        )
        
    }
    
}
