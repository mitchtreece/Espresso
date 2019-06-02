//
//  Array+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import Foundation

public extension Array /* Prepend */ {
    
    /**
     Prepends an element to the array.
     
     - Parameter newElement: The element to prepend.
     */
    mutating func prepend(_ newElement: Array.Element) {
        self.insert(newElement, at: 0)
    }
    
    /**
     Prepends a sequence of elements to the array.
     
     - Parameter newElements: The elements to prepend.
     */
    mutating func prepend<S>(contentsOf newElements: S) where Element == S.Element, S: Sequence {
        
        newElements.reversed().forEach { (element) in
            self.insert(element, at: 0)
        }
        
    }
    
}

//public extension Array /* Difference */ {
//
//    func difference<S: Sequence>(with otherArray: S) -> [S] where Element == S.Element {
//
//              // Example:
//            let oldMessages = oldValue.value
//            let newMessages = newValue.value
//
//            var messageSet = Set(newMessages)
//            messageSet.subtract(oldMessages)
//
//            let diffMessages = Array(messageSet)
//
//    }
//
//}

// OR

//extension Array where Element: Hashable {
//    func difference(from other: [Element]) -> [Element] {
//        let thisSet = Set(self)
//        let otherSet = Set(other)
//        return Array(thisSet.symmetricDifference(otherSet))
//    }
//}

public extension Array where Element: Operation {
    
    /**
     Adds a completion handler to an array of `Operation`'s.
     
     - Parameter block: The completion handler.
     */
    func completion(block: @escaping ()->()) {
        
        let operation = BlockOperation(block: block)
        self.forEach { [unowned operation] in operation.addDependency($0) }
        OperationQueue().addOperation(operation)
        
    }
    
}
