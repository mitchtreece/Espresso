//
//  Data+Digest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation
import CommonCrypto

public extension Data {
    
    /// Hashes the data with a given digest method & format. Additionally adds an RSA-2048 ASN.1 header.
    /// - Parameter digest: The digest hashing method.
    /// - Parameter format: The digest hash format; _defaults to hex_.
    /// - Returns: A hashed string containing an RSA-2048 ASN.1 header.
    func hashWithRSA2048ASN1Header(using digest: CryptoDigest, format: CryptoDigest.Format = .hex) -> String? {
        
        let header: [UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]
        
        var headerData = Data(header)
        headerData.append(self)
        
        return hashed(
            using: digest,
            format: format
        )
        
    }
    
    /// Hashes the data with a given digest method & format.
    /// - Parameter digest: The digest hashing method.
    /// - Parameter format: The digest hash format; _defaults to hex_.
    /// - Returns: A hashed string.
    func hashed(using digest: CryptoDigest, format: CryptoDigest.Format = .hex) -> String? {
        
        var data = Data(count: Int(digest.length))
        
        _ = data.withUnsafeMutableBytes { digestBytes in
            
            self.withUnsafeBytes { messageBytes in

                digest.hash(
                    data: messageBytes.baseAddress!,
                    length: CC_LONG(self.count),
                    md: digestBytes.bindMemory(to: UInt8.self).baseAddress!
                )
                
            }
            
        }
        
        switch format {
        case .hex: return data.map { String(format: "%02hhx", $0) }.joined()
        case .base64: return data.base64EncodedString()
        }
        
    }
    
}
