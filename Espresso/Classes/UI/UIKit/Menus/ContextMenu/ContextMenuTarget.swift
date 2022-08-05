//
//  ContextMenuTarget.swift
//  Espresso
//
//  Created by Mitch Treece on 8/1/22.
//

import UIKit

/// Protocol describing something that can be the target of context menu interactions.
public protocol ContextMenuTarget {
    
    var interactions: [UIInteraction] { get }
    
    func addInteraction(_ interaction: UIInteraction)
    func removeInteraction(_ interaction: UIInteraction)
    
}

extension UIView: ContextMenuTarget {}

public extension ContextMenuTarget {
    
    // Adds or replaces a context menu
    // Doesn't hold a strong ref
    func addContextMenu(_ contextMenu: ContextMenu) {
        
        if let existingInteraction = self.interactions.first(where: { $0 is UIContextMenuInteraction }) {
            removeInteraction(existingInteraction)
        }
                        
        let interaction = UIContextMenuInteraction(delegate: contextMenu)
        
        contextMenu.interaction = interaction
        
        addInteraction(interaction)
        
    }
    
    // Adds or replaces a context menu
    // Doesn't hold strong ref
    @discardableResult
    func addContextMenu(builder: (inout ContextMenuBuildable)->()) -> ContextMenu { // -> ContextMenuInteractable
    
        var buildable: ContextMenuBuildable = ContextMenuBuilder()
        builder(&buildable)

        let contextMenu = ContextMenu(buildable: buildable)
    
        addContextMenu(contextMenu)
    
        return contextMenu
    
    }
    
    // Removes the context menu from the target.
    func removeContextMenu(_ contextMenu: ContextMenu) {
        
        guard let interaction = contextMenu.interaction else { return }
        removeInteraction(interaction)
        
    }
    
}
