//
//  CryptoDigest.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import Foundation
import CommonCrypto

//internal protocol Digest {
//    func generate(for bytes: [UInt8]) -> [UInt8]
//}
//
//public struct CryptoDigest {
//
////    case md5
////    case sha1
////    case sha224
////    case sha256
////    case sha384
////    case sha512
////    case sha3
//
//    public static func md5(_ bytes: [UInt8]) -> [UInt8] {
//        return []
//    }
//
//}

public enum CryptoDigest {
    
    public enum OutputFormat {
        case hex
        case base64
    }
    
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
    
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
    
}
