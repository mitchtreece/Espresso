//
//  EnumIterable.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public protocol EnumIterable: Hashable {
    
    static var all: [Self] { get }
    static func item(at index: Int) -> Self?
    
}

extension EnumIterable {
    
    public static var all: [Self] {
        
        let cases = AnySequence { () -> AnyIterator<Self> in
            
            var raw: Int = 0
            
            return AnyIterator {
                
                let current: Self = withUnsafePointer(to: &raw, { $0.withMemoryRebound(to: Self.self, capacity: 1, { $0.pointee }) })
                guard current.hashValue == raw else { return nil }
                
                raw += 1
                return current
                
            }
            
        }
        
        return Array(cases)
        
    }
    
    public static func item(at index: Int) -> Self? {
        
        let cases = self.all
        guard index >= 0 && index < cases.count else { return nil }
        return cases[index]
        
    }
    
}
