//
//  Feature.swift
//  Espresso
//
//  Created by Mitch Treece on 6/12/22.
//

import Foundation

open class Feature {
    
    public let name: String
    public let description: String?
    
    public init(name: String,
                description: String? = nil) {
        
        self.name = name
        self.description = description
        
    }
    
}

open class ConditionalFeature: Feature {
    
    public typealias Condition = ()->(Bool)
        
    private let condition: Condition
    
    public init(name: String,
                description: String? = nil,
                condition: @escaping Condition) {
        
        super.init(
            name: name,
            description: description
        )
        
        self.condition = condition
        
    }
    
}
