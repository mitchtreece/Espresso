//
//  UIMenuElementContainer.swift
//  Espresso
//
//  Created by Mitch Treece on 8/4/22.
//

import UIKit

@available(iOS 14, *)
public typealias UIDeferredMenuElementCompletion = ([UIMenuElement])->()

public protocol UIMenuElementContainer {
    
    var children: [UIMenuElement] { get set }
    
}

public extension UIMenuElementContainer {
    
    // MARK: Add
    
    mutating func addElement(_ element: UIMenuElement) {
        self.children.append(element)
    }
    
    @discardableResult
    mutating func addAction(builder: (inout UIActionBuildable)->()) -> UIMenuElementIdentifier {
        
        var buildable: UIActionBuildable = UIActionBuilder()
        builder(&buildable)
        
        let action = (buildable as! UIActionBuilder).build()
        addElement(action)
        
        return action.identifier.rawValue
        
    }
    
    @discardableResult
    mutating func addMenu(builder: (inout UIMenuBuildable)->()) -> UIMenuElementIdentifier {
        
        var buildable: UIMenuBuildable = UIMenuBuilder()
        builder(&buildable)
        
        let menu = (buildable as! UIMenuBuilder).build()
        addElement(menu)
        
        return menu.identifier.rawValue
        
    }
    
    @available(iOS 14, *)
    mutating func addDeferredElements(block: @escaping (@escaping UIDeferredMenuElementCompletion)->()) {
        
        // Not using builders here because we only pass in one (required) thing.
        // Also, the way to init an `uncached` deferred element is a static function,
        // so the builder pattern `init(buildable:)` won't work.
        
        addElement(UIDeferredMenuElement(block))
        
    }
    
    @available(iOS 15, *)
    mutating func addUncachedDeferredElements(block: @escaping (@escaping UIDeferredMenuElementCompletion)->()) {
        
        // Not using builders here because we only pass in one (required) thing.
        // Also, the way to init an `uncached` deferred element is a static function,
        // so the builder pattern `init(buildable:)` won't work.
        
        addElement(UIDeferredMenuElement.uncached(block))
        
    }
    
}
