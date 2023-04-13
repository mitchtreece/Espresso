//
//  NewVersion+Codable.swift
//  Espresso
//
//  Created by Mitch Treece on 6/15/22.
//

import Foundation

extension Version: Codable {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        do {
            self = try Version(string)
        }
        catch {
            
            // TODO: Be more explicit about why the semantic version is invalid
            // `error` is a Version.Error, so we have more info we could surface
            
            throw DecodingError
                .dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid semantic version"
                )
            
        }
                
    }

    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
        
    }
    
}
