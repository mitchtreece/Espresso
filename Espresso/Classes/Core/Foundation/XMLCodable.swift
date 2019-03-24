//
//  XMLCodable.swift
//  Espresso
//
//  Created by Mitch Treece on 3/14/19.
//

// NOTE: Still working on this.
// Will uncomment and release when ready.

//import Foundation
//
//public protocol XMLValueRepresentable {}
//extension String: XMLValueRepresentable {}
//extension Double: XMLValueRepresentable {}
//extension Float: XMLValueRepresentable {}
//extension CGFloat: XMLValueRepresentable {}
//extension Int: XMLValueRepresentable {}
//
//public protocol XMLCodable {
//    func xml(tag: String) -> XMLContainer
//}
//
//public class XMLContainer {
//    
//    public private(set) var tag: String
//    public private(set) var value: XMLValueRepresentable?
//    
//    private var children = [XMLContainer]()
//    
//    public init(tag: String, value: XMLValueRepresentable? = nil) {
//        
//        self.tag = tag
//        self.value = value
//        
//    }
//    
//    public func append(child container: XMLContainer) -> Self {
//        
//        self.children.append(container)
//        return self
//        
//    }
//
//    public func append(tag: String, value: XMLValueRepresentable) -> Self {
//        
//        let container = XMLContainer(tag: tag, value: value)
//        return append(child: container)
//        
//    }
//    
//    public func append(tag: String, from codable: XMLCodable) -> Self {
//        
//        let container = codable.xml(tag: tag)
//        return append(child: container)
//        
//    }
//    
//    public var rawValue: String {
//        
//        if let value = self.value {
//            return "<\(self.tag)>\(value)</\(self.tag)>"
//        }
//        
//        let content = self.children.map { $0.rawValue }.joined()
//        return "<\(self.tag)>\(content)</\(self.tag)>"
//        
//    }
//    
//}
