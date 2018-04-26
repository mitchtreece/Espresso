//
//  CaseIterable.swift
//  Espresso
//
//  Created by Mitch Treece on 4/26/18.
//

import Foundation

// NOTE: This is built in to the standard library as of Swift 4.2

#if swift(>=4.2)
#else

public protocol CaseIterable {
    
    associatedtype AllCases: Collection where AllCases.Element == Self
    static var allCases: AllCases { get }
    
}

extension CaseIterable where Self: Hashable {
    
    public static var allCases: [Self] {
        
        return [Self](AnySequence { () -> AnyIterator<Self> in
            
            var raw = 0
            
            return AnyIterator {
                
                let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
                
            }
            
        })
        
    }
    
}

#endif
