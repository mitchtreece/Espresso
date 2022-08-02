////
////  ContextMenuElementContainer.swift
////  Espresso
////
////  Created by Mitch Treece on 7/29/22.
////
//
//import Foundation
//
///// Protocol describing the attributes of a context menu element container.
//public protocol ContextMenuElementContainer {
//    
//    /// The container's elements.
//    var elements: [ContextMenuElement] { get set }
//    
//}
//
//public extension ContextMenuElementContainer {
//    
//    /// Adds an element to the container.
//    ///
//    /// - parameter element: The element to add.
//    /// - returns: This element container.
//    @discardableResult
//    mutating func addElement(_ element: ContextMenuElement) -> Self {
//        
//        self.elements
//            .append(element)
//        
//        return self
//        
//    }
//            
//    /// Adds an action-element to the container using a building closure.
//    ///
//    /// - parameter block: The action-element building closure.
//    /// - returns: This element container.
//    @discardableResult
//    mutating func addAction(_ block: (inout ContextMenuActionBuilder)->()) -> Self {
//        
//        var builder = ContextMenuActionBuilder()
//        block(&builder)
//        
//        addElement(builder.buildElement())
//        
//        return self
//        
//    }
//    
//    /// Adds a menu-element to the container using a building closure.
//    ///
//    /// - parameter block: The menu-building closure.
//    /// - returns: This element container.
//    @discardableResult
//    mutating func addMenu(_ block: (inout ContextMenuBuilder)->()) -> Self {
//        
//        var builder = ContextMenuBuilder()
//        block(&builder)
//        
//        addElement(builder.buildElement())
//        
//        return self
//        
//    }
//    
////    func addDeferredElement(_ block: (inout ContextMenuDeferredElementBuilder)->()) -> Self {
////        
////    }
//        
//}
