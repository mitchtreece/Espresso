//
//  UIView+UIContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public extension UIView {
    
    // NOTE: addContextMenu(menu:) & addInteraction(interaction:)
    // *do not* retain a reference to your context menu / interaction delegate.
    // You *must* hold onto a reference yourself.
    
    func addContextMenu(_ menu: UIContextMenu) {

        if #available(iOS 14, *) {
            
            if let button = self as? UIButton {
                button.menu = menu.buildMenu()
            }
            else {
                addInteraction(UIContextMenuInteraction(delegate: menu))
            }
            
        }
        else {
            addInteraction(UIContextMenuInteraction(delegate: menu))
        }
        
    }
    
}
