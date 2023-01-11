//
//  JSONRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

/// Protocol describing something that can be represented as a JSON object.
public protocol JSONRepresentable {
    
    /// A json representation.
    /// - returns: A `JSON` object.
    func asJson() -> JSON?
    
    /// A json data representation.
    /// - parameter options: Options to use when writing json data.
    /// - returns: `JSON` data.
    func asJsonData(options: JSONSerialization.WritingOptions) -> Data?
    
}

public extension JSONRepresentable {
    
    /// A json data representation.
    /// - returns: `JSON` data.
    func asJsonData() -> Data? {
        return asJsonData(options: [])
    }
    
}

/// Protocol describing something that can be represented as a JSON object array.
public protocol JSONArrayRepresentable {
    
    /// A json-array representation.
    /// - returns: A `JSON` array.
    func asJsonArray() -> [JSON]?
    
    /// a json-array data representation.
    /// - parameter options: Options to use when writing json data.
    /// - returns: `JSON` array data.
    func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data?
    
}

public extension JSONArrayRepresentable {
    
    func asJsonArrayData() -> Data? {
        return asJsonArrayData(options: [])
    }
    
}

extension Dictionary: JSONRepresentable,
                      JSONArrayRepresentable where Key == JSON.Key, Value == JSON.Value {
    
    public func asJson() -> JSON? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        return self
        
    }
    
    public func asJsonData(options: JSONSerialization.WritingOptions) -> Data? {
        
        guard let json = asJson() else { return nil }
        
        return try? JSONSerialization.data(
            withJSONObject: json,
            options: options
        )
        
    }
    
    public func asJsonArray() -> [JSON]? {

        guard let json = asJson() else { return nil }
        return [json]

    }

    public func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data? {

        guard let array = asJsonArray() else { return nil }

        return try? JSONSerialization.data(
            withJSONObject: array,
            options: options
        )

    }
    
}

extension Array: JSONArrayRepresentable where Element == JSON {
    
    public func asJsonArray() -> [JSON]? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        return self
        
    }
    
    public func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data? {
        
        guard let array = asJsonArray() else { return nil }
        
        return try? JSONSerialization.data(
            withJSONObject: array,
            options: options
        )
        
    }
    
}

extension Data: JSONRepresentable,
                JSONArrayRepresentable {
    
    public func asJson() -> JSON? {
        
        return try? JSONSerialization
            .jsonObject(with: self) as? JSON
        
    }
    
    public func asJsonData(options: JSONSerialization.WritingOptions) -> Data? {
        
        guard let json = asJson() else { return nil }
        
        if options.isEmpty {
            return self
        }
        
        return json
            .asJsonData(options: options)
        
    }
    
    public func asJsonArray() -> [JSON]? {
        
        return try? JSONSerialization
            .jsonObject(with: self) as? [JSON]
        
    }
    
    public func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data? {
        
        guard let array = asJsonArray() else { return nil }
        
        if options.isEmpty {
            return self
        }
        
        return array
            .asJsonArrayData(options: options)
        
    }
    
}

// NOTE: We can't add protocol conformance to another protocol
// via an extension. Just replicating conformance here to keep
// the semantics the same everywhere.

public extension Encodable {
    
    /// A json representation.
    /// - returns: A `JSON` object.
    func asJson() -> JSON? {
        
        guard let data = asJsonData(),
              let json = try? JSONSerialization.jsonObject(with: data) as? JSON else { return nil }
        
        return json

    }
    
    /// A json data representation.
    /// - returns: `JSON` data.
    func asJsonData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    /// A json-array representation.
    /// - returns: A `JSON` array.
    func asJsonArray() -> [JSON]? {
        
        guard let data = asJsonArrayData(),
              let array = try? JSONSerialization.jsonObject(with: data) as? [JSON] else { return nil }
        
        return array
        
    }
    
    /// A json-array data representation.
    /// - returns: `JSON` array data.
    func asJsonArrayData() -> Data? {
        return asJsonData()
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
    /// - parameter jsons: The `JSON` array to create the decodables with.
    /// - returns: An array of decodables.
    static func from(jsons: [JSON]) -> [Self]? {

        let objects = jsons
            .compactMap { $0.asJsonData() }
            .compactMap { try? JSONDecoder().decode(Self.self, from: $0) }
                
        if objects.isEmpty {
            return nil
        }
        
        return objects

    }

}
