//
//  ContextMenuAction.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public protocol ContextMenuAction: ContextMenuElement {
    
    var description: String? { get set }
    var attributes: UIMenuElement.Attributes { get set }
    var state: UIMenuElement.State { get set }
    var action: UIActionHandler { get set }
    
}
