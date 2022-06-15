//
//  NewVersion+Codable.swift
//  Espresso
//
//  Created by Mitch Treece on 6/15/22.
//

import Foundation

public extension CodingUserInfoKey {
    
    static let decodingMethod = CodingUserInfoKey(rawValue: "com.mitchtreece.Espresso.Version.decodingMethod")!
    
}

extension Version: Codable {
    
    public enum DecodingMethod {
        
        case strict
        case tolerant
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        let initializer: (String)->(Version?)
        
        if decoder.userInfo[.decodingMethod] as? DecodingMethod == .tolerant {
            initializer = Version.init(tolerant:)
        }
        else {
            initializer = Version.init
        }
        
        guard let version = initializer(string) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid semantic version")
        }
        
        self = version
        
    }

    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
        
    }
    
}
