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
    
    /// A json representation.
    /// - returns: A `JSON` object, or a thrown error.
    func asJsonThrowing() throws -> JSON
    
    /// A json data representation.
    /// - parameter options: Options to use when writing json data.
    /// - returns: `JSON` data.
    func asJsonData(options: JSONSerialization.WritingOptions) -> Data?
    
    /// A json data representation.
    /// - parameter options: Options to use when writing json data.
    /// - returns: `JSON` data, or a thrown error.
    func asJsonDataThrowing(options: JSONSerialization.WritingOptions) throws -> Data
    
}

public extension JSONRepresentable {
    
    /// A json data representation.
    /// - returns: `JSON` data.
    func asJsonData() -> Data? {
        return asJsonData(options: [])
    }
    
    /// A json data representation.
    /// - returns: `JSON` data, or a thrown error.
    func asJsonDataThrowing() throws -> Data {
        return try asJsonDataThrowing(options: [])
    }
    
}

/// Protocol describing something that can be represented as a JSON object array.
public protocol JSONArrayRepresentable {
    
    /// A json-array representation.
    /// - returns: A `JSON` array.
    func asJsonArray() -> [JSON]?
    
    /// A json-array representation.
    /// - returns: A `JSON` array, or a thrown error.
    func asJsonArrayThrowing() throws -> [JSON]
    
    /// a json-array data representation.
    /// - parameter options: Options to use when writing json data.
    /// - returns: `JSON` array data.
    func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data?
    
    /// A json-array data representation.
    /// - parameter options: Options to use when writing json data.
    /// - returns: `JSON` array data, or a thrown error.
    func asJsonArrayDataThrowing(options: JSONSerialization.WritingOptions) throws -> Data
    
}

public extension JSONArrayRepresentable {
    
    /// a json-array data representation.
    /// - returns: `JSON` array data.
    func asJsonArrayData() -> Data? {
        return asJsonArrayData(options: [])
    }
    
    /// A json-array data representation.
    /// - returns: `JSON` array data, or a thrown error.
    func asJsonArrayDataThrowing() throws -> Data {
        return try asJsonArrayDataThrowing(options: [])
    }
    
}

extension Dictionary: JSONRepresentable,
                      JSONArrayRepresentable where Key == JSON.Key, Value == JSON.Value {
    
    public func asJsonThrowing() throws -> JSON {
        
        guard JSONSerialization.isValidJSONObject(self) else { throw JSONError.invalidObject }
        return self
        
    }
    
    public func asJson() -> JSON? {
        return try? asJsonThrowing()
    }
    
    public func asJsonDataThrowing(options: JSONSerialization.WritingOptions) throws -> Data {
                
        let json = try asJsonThrowing()
        
        return try JSONSerialization.data(
            withJSONObject: json,
            options: options
        )
        
    }
    
    public func asJsonData(options: JSONSerialization.WritingOptions) -> Data? {
        return try? asJsonDataThrowing(options: options)
    }
    
    public func asJsonArrayThrowing() throws -> [JSON] {
        
        let json = try asJsonThrowing()
        return [json]
        
    }
    
    public func asJsonArray() -> [JSON]? {
        return try? asJsonArrayThrowing()
    }
    
    public func asJsonArrayDataThrowing(options: JSONSerialization.WritingOptions) throws -> Data {
        
        let array = try asJsonArrayThrowing()
        
        return try JSONSerialization.data(
            withJSONObject: array,
            options: options
        )
        
    }

    public func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data? {
        return try? asJsonArrayDataThrowing(options: options)
    }
    
}

extension Array: JSONArrayRepresentable where Element == JSON {
    
    public func asJsonArrayThrowing() throws -> [JSON] {
        
        guard JSONSerialization.isValidJSONObject(self) else { throw JSONError.invalidObject }
        return self
        
    }
    
    public func asJsonArray() -> [JSON]? {
        return try? asJsonArrayThrowing()
    }
    
    public func asJsonArrayDataThrowing(options: JSONSerialization.WritingOptions) throws -> Data {
        
        let array = try asJsonArrayThrowing()
        
        return try JSONSerialization.data(
            withJSONObject: array,
            options: options
        )
        
    }
    
    public func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data? {
        return try? asJsonArrayDataThrowing(options: options)
    }
    
}

extension Data: JSONRepresentable,
                JSONArrayRepresentable {
    
    public func asJsonThrowing() throws -> JSON {
        
        let object = try JSONSerialization
            .jsonObject(with: self)
        
        guard let json = object as? JSON else {
            throw JSONError.invalidObject
        }
        
        return json
        
    }
    
    public func asJson() -> JSON? {
        return try? asJsonThrowing()
    }
    
    public func asJsonDataThrowing(options: JSONSerialization.WritingOptions) throws -> Data {
        
        let json = try asJsonThrowing()
        
        if options.isEmpty {
            return self
        }
        
        return try json
            .asJsonDataThrowing(options: options)
        
    }
    
    public func asJsonData(options: JSONSerialization.WritingOptions) -> Data? {
        return try? asJsonDataThrowing(options: options)
    }
    
    public func asJsonArrayThrowing() throws -> [JSON] {
        
        let object = try JSONSerialization
            .jsonObject(with: self)
        
        guard let array = object as? [JSON] else {
            throw JSONError.invalidObject
        }
        
        return array
        
    }
    
    public func asJsonArray() -> [JSON]? {
        return try? asJsonArrayThrowing()
    }
    
    public func asJsonArrayDataThrowing(options: JSONSerialization.WritingOptions) throws -> Data {
        
        let array = try asJsonArrayThrowing()
        
        if options.isEmpty {
            return self
        }
        
        return try array
            .asJsonArrayDataThrowing(options: options)
        
    }
    
    public func asJsonArrayData(options: JSONSerialization.WritingOptions) -> Data? {
        return try? asJsonArrayDataThrowing(options: options)
    }
    
}

// NOTE: We can't add protocol conformance to another protocol
// via an extension. Just replicating conformance here to keep
// the semantics the same everywhere.

public extension Encodable {
    
    /// A json representation.
    /// - returns: A `JSON` object, or a thrown error.
    func asJsonThrowing() throws -> JSON {
        
        let data = try asJsonDataThrowing()
        
        let object = try JSONSerialization
            .jsonObject(with: data)
        
        guard let json = object as? JSON else {
            throw JSONError.invalidObject
        }
        
        return json
        
    }
    
    /// A json representation.
    /// - returns: A `JSON` object.
    func asJson() -> JSON? {
        
        guard let data = asJsonData(),
              let json = try? JSONSerialization.jsonObject(with: data) as? JSON else { return nil }
        
        return json

    }
    
    /// A json data representation.
    /// - returns: `JSON` data, or a thrown error.
    func asJsonDataThrowing() throws -> Data {
        
        return try JSONEncoder()
            .encode(self)
        
    }
    
    /// A json data representation.
    /// - returns: `JSON` data.
    func asJsonData() -> Data? {
        return try? asJsonDataThrowing()
    }
    
    /// A json-array representation.
    /// - returns: A `JSON` array, or a thrown error.
    func asJsonArrayThrowing() throws -> [JSON] {
        
        let data = try asJsonArrayDataThrowing()
        
        let object = try JSONSerialization
            .jsonObject(with: data)
        
        guard let array = object as? [JSON] else {
            throw JSONError.invalidObject
        }
        
        return array
        
    }
    
    /// A json-array representation.
    /// - returns: A `JSON` array.
    func asJsonArray() -> [JSON]? {
        return try? asJsonArrayThrowing()
    }
    
    /// A json-array data representation.
    /// - returns: `JSON` array data, or a thrown error.
    func asJsonArrayDataThrowing() throws -> Data {
        return try asJsonDataThrowing()
    }
    
    /// A json-array data representation.
    /// - returns: `JSON` array data.
    func asJsonArrayData() -> Data? {
        return try? asJsonArrayDataThrowing()
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
