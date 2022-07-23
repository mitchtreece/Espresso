//
//  JSONType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import Foundation

public typealias JSON = [String: Any]

/// Protocol describing something that can be represented as `JSON`.
public protocol JSONType {
    //
}

extension Dictionary: JSONType where Key == String, Value == Any {
    
    /// A json representation.
    public var jsonValue: JSON? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        return self
        
    }
    
    /// A json data representation.
    public var jsonDataValue: Data? {
        
        guard let json = self.jsonValue else { return nil }
        return try? JSONSerialization.data(withJSONObject: json)
        
    }
    
}

extension Array: JSONType where Element == JSON {
    
    /// A json array representation.
    public var jsonValue: [JSON]? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        return self
        
    }
    
    /// A json data representation.
    public var jsonDataValue: Data? {
        
        guard let array = self.jsonValue else { return nil }
        return try? JSONSerialization.data(withJSONObject: array)
        
    }
    
}

extension Data: JSONType {
    
    /// A json representation.
    public var jsonValue: JSON? {
        return try? JSONSerialization.jsonObject(with: self) as? JSON
    }
    
    /// A json array representation.
    public var jsonArrayValue: [JSON]? {
        return try? JSONSerialization.jsonObject(with: self) as? [JSON]
    }
    
}
