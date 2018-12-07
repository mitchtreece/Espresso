//
//  Data+Digest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation
import CommonCrypto

public extension Data {

    /**
     Hashes the data with a given digest method & output format. Additionally adds an RSA-2048 ASN.1 header.
     - Parameter digest: The digest hashing method.
     - Parameter format: The digest hash output format; _defaults to hex_.
     - Returns: A hashed string containing an RSA-2048 ASN.1 header.
     */
    public func hashWithRSA2048ASN1Header(digest: CryptoDigest, format: CryptoDigest.OutputFormat = .hex) -> String? {
        
        let header: [UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]
        
        var headerData = Data(bytes: header)
        headerData.append(self)
        
        return hashed(with: digest, format: format)
        
    }
    
    /**
     Hashes the data with a given digest method & output format.
     - Parameter digest: The digest hashing method.
     - Parameter format: The digest hash output format; _defaults to hex_.
     - Returns: A hashed string.
     */
    public func hashed(with digest: CryptoDigest, format: CryptoDigest.OutputFormat = .hex) -> String? {
        
        var data = Data(count: Int(digest.length))
        
        _ = data.withUnsafeMutableBytes { (digestBytes: UnsafeMutablePointer<UInt8>) in
            
            self.withUnsafeBytes { (messageBytes: UnsafePointer<UInt8>) in
                
                let length = CC_LONG(self.count)
                
                switch digest {
                case .md5: CC_MD5(messageBytes, length, digestBytes)
                case .sha1: CC_SHA1(messageBytes, length, digestBytes)
                case .sha224: CC_SHA224(messageBytes, length, digestBytes)
                case .sha256: CC_SHA256(messageBytes, length, digestBytes)
                case .sha384: CC_SHA384(messageBytes, length, digestBytes)
                case .sha512: CC_SHA512(messageBytes, length, digestBytes)
                }
                
            }
            
        }
        
        switch format {
        case .hex: return data.map { String(format: "%02hhx", $0) }.joined()
        case .base64: return data.base64EncodedString()
        }
        
    }
    
}
