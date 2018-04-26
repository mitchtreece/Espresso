//
//  Array+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import Foundation

// MARK: Safety

public extension Collection {
    
    public subscript(safe index: Index) -> Element? {
        
        if distance(to: index) >= 0 && distance(from: index) > 0 {
            return self[index]
        }
        
        return nil
        
    }
    
    public subscript(safe bounds: Range<Index>) -> SubSequence? {
        
        if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) >= 0 {
            return self[bounds]
        }
        
        return nil
        
    }
    
    public subscript(safe bounds: ClosedRange<Index>) -> SubSequence? {
        
        if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) > 0 {
            return self[bounds]
        }
        
        return nil
        
    }
    
    private func distance(from startIndex: Index) -> Int {
        return distance(from: startIndex, to: self.endIndex)
    }
    
    private func distance(to endIndex: Index) -> Int {
        return distance(from: self.startIndex, to: endIndex)
    }
    
}
