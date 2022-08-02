//
//  ContextMenuAction.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

/// Protocol describing the attributes of context menu action.
public protocol ContextMenuAction: ContextMenuElement {
    
    /// The element's attributes.
    var attributes: UIMenuElement.Attributes { get set }
    
    /// The element's state.
    var state: UIMenuElement.State { get set }
    
    /// The element's action handler.
    var action: UIActionHandler { get set }
    
}
