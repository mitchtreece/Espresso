//
//  ContextMenuBuildable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import Foundation

public protocol ContextMenuBuildable {
    
    var elements: [ContextMenuElement] { get set }
    
}

public extension ContextMenuBuildable {
    
    @discardableResult
    mutating func addElement(_ element: ContextMenuElement) -> Self {
        
        self.elements
            .append(element)
        
        return self
        
    }
    
    @discardableResult
    mutating func addAction(_ block: (inout ContextMenuActionBuilder)->()) -> Self {
        
        var builder = ContextMenuActionBuilder()
        block(&builder)
        
        addElement(builder.build())
        
        return self
        
    }
    
    @discardableResult
    mutating func addMenu(_ block: (inout ContextMenuBuilder)->()) -> Self {
        
        var builder = ContextMenuBuilder()
        block(&builder)
        
        addElement(builder.build())
        
        return self
        
    }
    
}
