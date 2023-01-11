//
//  Collection+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import Foundation

public extension Collection /* Safety */ {
    
    /// Safely returns an element at a given index.
    /// - Parameter index: The element's index.
    /// - Returns: An optional element.
    subscript(safe index: Index) -> Element? {
        
        if distance(to: index) >= 0 && distance(from: index) > 0 {
            return self[index]
        }
        
        return nil
        
    }
    
    /// Safely returns a sub-sequence of elements.
    /// - Parameter bounds: The element range.
    /// - Returns: An optional array  `SubSequence`.
    subscript(safe bounds: Range<Index>) -> SubSequence? {
        
        if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) >= 0 {
            return self[bounds]
        }
        
        return nil
        
    }

    /// Safely returns a sub-sequence of elements.
    /// - Parameter bounds: The element range.
    /// - Returns: An optional array  `SubSequence`.
    subscript(safe bounds: ClosedRange<Index>) -> SubSequence? {
        
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

public extension Collection /* Chunk */ {

    /// Returns a chunked version of the collection using a given chunk size.
    /// - parameter size: The chunk size.
    /// - returns: An array of chunked sub-sequences.
    func chunked(size: Int) -> [SubSequence] {

        var chunks = [SubSequence]()
        var i = self.startIndex
        var j: Index

        while i != self.endIndex {

            j = index(i, offsetBy: size, limitedBy: self.endIndex) ?? self.endIndex
            chunks.append(self[i..<j])
            i = j

        }

        return chunks

    }

}

public extension Collection /* Nil */ {
    
    /// Returns the collection *or* nil if empty.
    /// - returns: An optional collection.
    func nilIfEmpty() -> Self? {
        self.isEmpty ? nil : self
    }
    
}
