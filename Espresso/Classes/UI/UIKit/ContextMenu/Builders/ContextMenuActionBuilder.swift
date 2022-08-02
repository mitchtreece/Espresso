//
//  ContextMenuActionBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

/// A context menu action builder.
public struct ContextMenuActionBuilder: ContextMenuElementBuilder {
        
    /// The action's title; _defaults to `empty`_.
    public var title: String = .empty
    
    /// The action's subtitle; _defaults to `nil`_.
    public var subtitle: String?
    
    /// The action's image; _defaults to `nil`_.
    public var image: UIImage?
    
    /// The action's identifier; _defaults to `nil`_.
    public var identifier: String?
    
    /// The action's attributes; _defaults to none_.
    public var attributes: UIMenuElement.Attributes = []
    
    /// The action's state; _defaults to `off`_.
    public var state: UIMenuElement.State = .off
    
    /// The action's action handler; _defaults to `nil`_.
    public var action: UIActionHandler?
    
    internal init() {
        //
    }
        
    internal func buildElement() -> ContextMenuElement {
        
        return UIContextMenuAction(
            title: self.title,
            subtitle: self.subtitle,
            image: self.image,
            identifier: self.identifier,
            attributes: self.attributes,
            state: self.state,
            action: self.action ?? { _ in }
        )
        
    }
    
}
