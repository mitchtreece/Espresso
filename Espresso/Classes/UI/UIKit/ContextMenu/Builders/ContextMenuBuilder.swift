//
//  ContextMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

/// A context menu sub-menu builder.
public struct ContextMenuBuilder: ContextMenuElementBuilder, ContextMenuElementContainer {
            
    /// The menu's title; _defaults to `empty`_.
    public var title: String = .empty
    
    /// The menu's subtitle; _defaults to `nil`_.
    public var subtitle: String?
    
    /// The menu's image; _defaults to `nil`_.
    public var image: UIImage?
    
    /// The menu's identifier; _defaults to `nil`_.
    public var identifier: String?
    
    /// The menu's options; _defaults to none_.
    public var options: UIMenu.Options = []
    
    /// The menu's elements; _defaults to none_.
    public var elements: [ContextMenuElement] = []
    
    internal init() {
        //
    }
    
    internal func buildElement() -> ContextMenuElement {
        
        return UIContextMenuSubMenu(
            title: self.title,
            subtitle: self.subtitle,
            image: self.image,
            identifier: self.identifier,
            options: self.options,
            elements: self.elements
        )
        
    }
    
}
