//
//  MenuElementContainer.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import Foundation

public protocol MenuElementContainer {
    
    var elements: [any MenuElement] { get set }
    
}

public extension MenuElementContainer {
    
    /// Adds an element to the container.
    ///
    /// - parameter element: The element to add.
    /// - returns: This element container.
    @discardableResult
    mutating func addElement(_ element: any MenuElement) -> Self {
        
        self.elements
            .append(element)
        
        return self
        
    }
            
    /// Adds an action-element to the container using a building closure.
    ///
    /// - parameter block: The action-element building closure.
    /// - returns: This element container.
    @discardableResult
    mutating func addAction(_ block: (inout MenuActionBuilder)->()) -> Self {

        var builder = MenuActionBuilder()
        block(&builder)

        addElement(builder.build())

        return self

    }

    /// Adds a menu-element to the container using a building closure.
    ///
    /// - parameter block: The menu-building closure.
    /// - returns: This element container.
    @discardableResult
    mutating func addMenu(_ block: (inout MenuBuilder)->()) -> Self {

        var builder = MenuBuilder()
        block(&builder)

        addElement(builder.build())

        return self

    }

//    func addDeferredElement(_ block: (inout ContextMenuDeferredElementBuilder)->()) -> Self {
//
//    }
        
}
