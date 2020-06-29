//
//  CaseIterable.swift
//  Espresso
//
//  Created by Mitch Treece on 4/26/18.
//

import Foundation

#if swift(>=4.2)
    // Built into the standard library as of Swift 4.2
#else

/// Protocol describing a way to iterate over all cases of an enum.
public protocol CaseIterable {
    
    associatedtype AllCases: Collection where AllCases.Element == Self
    
    /// A collection containing all the cases of the enum.
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
