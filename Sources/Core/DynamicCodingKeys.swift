//
//  DynamicCodingKeys.swift
//  Espresso
//
//  Created by Mitch Treece on 7/28/22.
//

import Foundation

/// Dynamic coding keys that can be used to extract raw key values.
///
/// Useful when data is "keyed" using a value you need access to, such as an ID.
///
///     let childContainer = rootContainer.nestedContainer(
///         keyedBy: DynamicCodingKeys.self,
///         forKey: .myChildObject
///     )
///
///     var objectIds = [String]()
///
///     childContainer
///         .allKeys
///         .forEach { objectIds.append($0.stringValue) }
///
///     self.childObjectIds = objectIds
public struct DynamicCodingKeys: CodingKey {

    public var stringValue: String
    public var intValue: Int?
    
    public init?(stringValue: String) {
        self.stringValue = stringValue
    }

    public init?(intValue: Int) {
        
        self.intValue = intValue
        self.stringValue = String(intValue)
        
    }
    
}
