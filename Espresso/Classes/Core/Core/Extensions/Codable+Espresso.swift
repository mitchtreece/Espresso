//
//  Codable+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

public extension Encodable {

    /// Gets the `JSON` representation of this encodable.
    /// - returns: A `JSON` object.
    func asJson() -> JSON? {

        guard let data = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else { return nil }

        return json

    }

    /// Gets the `JSON`-array representation of this encodable.
    /// - returns: A `JSON` array.
    func asJsonArray() -> [JSON]? {

        guard let data = try? JSONEncoder().encode(self),
            let array = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            else { return nil }

        return array

    }

}

public extension Decodable {
    
    /// Initializes a decodable using a `JSON` object.
    /// - parameter json: The `JSON` object to initialize the decodable with.
    init?(json: JSON) {
        
        guard let data = try? JSONSerialization.data(withJSONObject: json),
              let object = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        
        self = object
                
    }
    
    /// Creates an array of decodables from an array of `JSON` objects.
    /// - parameter jsonArray: The `JSON`-array to create the decodables with.
    /// - returns: An array of decodables.
    static func from(jsonArray: [JSON]) -> [Self]? {

        let objects = jsonArray
            .compactMap { try? JSONSerialization.data(withJSONObject: $0) }
            .compactMap { try? JSONDecoder().decode(Self.self, from: $0) }
        
        guard !objects.isEmpty else { return nil }
        
        return objects

    }

}
