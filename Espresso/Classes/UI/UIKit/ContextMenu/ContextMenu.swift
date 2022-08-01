//
//  ContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public protocol ContextMenu: ContextMenuElement {
    
    var options: UIMenu.Options { get set }
    var elements: [ContextMenuElement] { get set }
    
}
