//
//  ContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

/// Protocol describing the attributes of a context menu.
public protocol ContextMenu: ContextMenuElement, ContextMenuElementContainer {
    
    /// The element's options.
    var options: UIMenu.Options { get set }
    
}
