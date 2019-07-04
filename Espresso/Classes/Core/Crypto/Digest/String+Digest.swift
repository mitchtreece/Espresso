//
//  String+Digest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation

public extension String {
    
    /**
     Hashes the string with a given digest method & output format.
     - Parameter digest: The digest hashing method.
     - Parameter format: The digest hash output format; _defaults to hex_.
     - Returns: A hashed string.
     */
    func hashed(with digest: CryptoDigest, format: CryptoDigest.OutputFormat = .hex) -> String? {

        guard let data = self.data(using: .utf8) else { return nil }
        return data.hashed(with: digest, format: format)
        
    }
    
}
