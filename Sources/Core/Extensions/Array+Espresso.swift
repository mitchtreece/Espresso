//
//  Array+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import Foundation

public extension Array /* Append & Prepend */ {
    
    /// Returns a new array by appending an element.
    ///
    /// - parameter element: The element to append.
    /// - returns: A new array with the appended element.
    func appending(_ element: Element) -> Array {

        var array = self
        array.append(element)
        return array

    }
    
    /// Returns a new array by appending a sequence of elements.
    ///
    /// - parameter elements: The elements to append.
    /// - returns: A new array with the appended elements.
    func appending<S: Sequence>(contentsOf newElements: S) -> Array where Element == S.Element {
        
        var array = self
        array.append(contentsOf: newElements)
        return array
        
    }
    
    /// Prepends an element to the array.
    ///
    /// - parameter newElement: The element to prepend.
    mutating func prepend(_ newElement: Array.Element) {
        self.insert(newElement, at: 0)
    }
    
    /// Prepends a sequence of elements to the array.
    ///
    /// - parameter newElements: The elements to prepend.
    mutating func prepend<S: Sequence>(contentsOf newElements: S) where Element == S.Element {
        
        newElements
            .reversed()
            .forEach { self.insert($0, at: 0) }
        
    }
    
    /// Returns a new array by prepending an element.
    ///
    /// - parameter element: The element to prepend.
    /// - returns: A new array with the prepended element.
    func prepending(_ element: Element) -> Array {

        var array = self
        array.prepend(element)
        return array

    }
    
    /// Returns a new array by prepending a sequence of elements.
    ///
    /// - parameter elements: The elements to prepend.
    /// - returns: A new array with the prepended elements.
    func prepending<S: Sequence>(contentsOf newElements: S) -> Array where Element == S.Element {

        var array = self
        
        newElements
            .reversed()
            .forEach { array.insert($0, at: 0) }
        
        return array

    }
    
}

public extension Array where Element: Equatable /* Remove */ {
    
    /// Removes a specified element.
    ///
    /// - parameter element: The element to remove.
    mutating func remove(_ element: Element) {
        
        guard let idx = firstIndex(of: element) else { return }
        remove(at: idx)
        
    }
    
}

public extension Array where Element: Operation {
    
    /// Adds a completion handler to an array of `Operation`'s.
    /// - Parameter block: The completion handler.
    func completion(block: @escaping ()->()) {
        
        let operation = BlockOperation(block: block)
        self.forEach { [unowned operation] in operation.addDependency($0) }
        OperationQueue().addOperation(operation)
        
    }
    
}
