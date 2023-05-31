//
//  CryptoDigest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation
import CryptoKit

/// Representation of the various digest hashing functions.
public enum CryptoDigest {
    
    /// Representation of the various digest hash formats.
    public enum Format {
        
        case hex
        case base64
        
        internal func string(for data: Data) -> String {
            
            switch self {
            case .hex:
                
                return data
                    .map { String(format: "%02hhx", $0) }
                    .joined()
                
            case .base64:
                
                return data
                    .base64EncodedString()
                
            }
            
        }
        
    }
    
    /// Representation of the various RSA types.
    public enum RSA {
        
        /// An RSA-1024 type.
        case rsa1024
        
        /// An RSA-2048 type.
        case rsa2048
        
        /// An RSA-3072 type.
        case rsa3072
        
        internal var asn1Header: [UInt8] {
            
            switch self {
            case .rsa1024:
                
                return [
                    0x30, 0x81, 0x9F, 0x30, 0x0D, 0x06, 0x09, 0x2A, 0x86, 0x48, 0x86, 0xF7,
                    0x0D, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x81, 0x8D, 0x00
                ]
                
            case .rsa2048:
                
                return [
                    0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
                    0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
                ]
                
            case .rsa3072:
                
                return [
                    0x30, 0x82, 0x01, 0xA2, 0x30, 0x0D, 0x06, 0x09, 0x2A, 0x86, 0x48, 0x86,
                    0xF7, 0x0D, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x8F, 0x00
                ]
                
            }
            
        }
        
    }
    
    /// An `MD5` hashing function
    case md5
    
    /// A `SHA1` hashing function
    case sha1
    
    /// A `SHA256` hashing function
    case sha256
    
    /// A `SHA384` hashing function
    case sha384
    
    /// A `SHA512` hashing function
    case sha512
    
    internal func hash(data: Data,
                       format: Format) -> String {
        
        var digestData: Data!
        
        switch self {
        case .md5: digestData = Data(Insecure.MD5.hash(data: data))
        case .sha1: digestData = Data(Insecure.SHA1.hash(data: data))
        case .sha256: digestData = Data(SHA256.hash(data: data))
        case .sha384: digestData = Data(SHA384.hash(data: data))
        case .sha512: digestData = Data(SHA512.hash(data: data))
        }
        
        return format
            .string(for: digestData)
        
    }
    
}
