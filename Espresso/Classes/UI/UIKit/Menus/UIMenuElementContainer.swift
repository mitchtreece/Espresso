//
//  UIMenuElementContainer.swift
//  Espresso
//
//  Created by Mitch Treece on 8/3/22.
//

import UIKit

public protocol UIMenuElementContainer {
    
    var elements: [UIMenuElement] { get set }
    
}

public extension UIMenuElementContainer {
    
    mutating func addElement(_ element: UIMenuElement) {
        self.elements.append(element)
    }
    
    mutating func addAction(builder: (inout UIActionBuildable)->()) {
        
        var buildable: UIActionBuildable = UIActionBuilder()
        builder(&buildable)
        
        let action = (buildable as! UIActionBuilder).build()
        addElement(action)
        
    }
    
    mutating func addMenu(builder: (inout UIMenuBuildable)->()) {
        
        var buildable: UIMenuBuildable = UIMenuBuilder()
        builder(&buildable)
        
        let menu = (buildable as! UIMenuBuilder).build()
        addElement(menu)
        
    }
    
    @available(iOS 14, *)
    mutating func addDeferredElements(block: @escaping (UIDeferredMenuElementCompletion)->()) {
        
        let builder = UIDeferredMenuElementBuilder(elementProvider: block)
        addElement(builder.build())
        
    }
    
}
