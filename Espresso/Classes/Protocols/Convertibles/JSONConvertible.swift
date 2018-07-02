//
//  JSONConvertible.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import Foundation

public typealias JSON = [String: Any]

/**
 Protocol describing the conversion to various `JSON` representations.
 */
public protocol JSONConvertible {
    
    /**
     A `JSON` representation.
     */
    var json: JSON? { get }
    
    /**
     A `JSON` array representation.
     */
    var jsonArray: [JSON]? { get }
    
    /**
     A `JSON` data representation.
     */
    var jsonData: Data? { get }
    
}

extension Dictionary: JSONConvertible {
    
    public var json: JSON? {
        
        if let json = self as? JSON {
            return json
        }
        
        return nil
        
    }
    
    public var jsonArray: [JSON]? {
        return nil
    }
    
    public var jsonData: Data? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        
        do {
            return try JSONSerialization.data(withJSONObject: self)
        }
        catch {
            return nil
        }
        
    }
    
}

extension Array: JSONConvertible {
    
    public var json: JSON? {
        return nil
    }
    
    public var jsonArray: [JSON]? {
        
        if let array = self as? [JSON] {
            return array
        }
        
        return nil
        
    }
    
    public var jsonData: Data? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        
        do {
            return try JSONSerialization.data(withJSONObject: self)
        }
        catch {
            return nil
        }
        
    }
    
}

extension Data: JSONConvertible {
    
    public var json: JSON? {
        
        var object: Any?
        
        do {
            object = try JSONSerialization.jsonObject(with: self)
        }
        catch {
            return nil
        }
        
        if let json = object as? JSON {
            return json
        }
        
        return nil
        
    }
    
    public var jsonArray: [JSON]? {
        
        var object: Any?
        
        do {
            object = try JSONSerialization.jsonObject(with: self)
        }
        catch {
            return nil
        }
        
        if let array = object as? [JSON] {
            return array
        }
        
        return nil
        
    }
    
    public var jsonData: Data? {
        return self
    }
    
}
