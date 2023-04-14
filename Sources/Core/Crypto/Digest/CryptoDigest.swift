//
//  CryptoDigest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation
import CommonCrypto

/// Representation of the various digest hashing functions.
public enum CryptoDigest {
    
    /// Representation of the various digest hash formats.
    public enum Format {
        
        case hex
        case base64
        
    }
    
    /// An `MD5` hashing method
    case md5
    
    /// A `SHA1` hashing method
    case sha1
    
    /// A `SHA224` hashing method
    case sha224
    
    /// A `SHA256` hashing method
    case sha256
    
    /// A `SHA384` hashing method
    case sha384
    
    /// A `SHA512` hashing method
    case sha512
    
    /// The hashing method's digest length in bytes.
    var length: Int32 {
        
        switch self {
        case .md5: return CC_MD5_DIGEST_LENGTH
        case .sha1: return CC_SHA1_DIGEST_LENGTH
        case .sha224: return CC_SHA224_DIGEST_LENGTH
        case .sha256: return CC_SHA256_DIGEST_LENGTH
        case .sha384: return CC_SHA384_DIGEST_LENGTH
        case .sha512: return CC_SHA384_DIGEST_LENGTH
        }
        
    }
    
    internal func hash(data: UnsafeRawPointer, length: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        
        switch self {
        case .md5: return CC_MD5(data, length, md)
        case .sha1: return CC_SHA1(data, length, md)
        case .sha224: return CC_SHA224(data, length, md)
        case .sha256: return CC_SHA256(data, length, md)
        case .sha384: return CC_SHA384(data, length, md)
        case .sha512: return CC_SHA512(data, length, md)
        }
        
    }
    
}
