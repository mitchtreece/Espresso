//
//  UIBarButtonItem+UIContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public extension UIBarButtonItem {
    
    @available(iOS 14, *)
    func addContextMenu(_ menu: UIContextMenu) {
        self.menu = menu.buildMenu()
    }
    
    @available(iOS 14, *)
    func addContextMenu(_ block: (inout ContextMenuRootBuilder)->()) -> UIContextMenu {
        
        var builder = ContextMenuRootBuilder()
        block(&builder)
        
        let menu = UIContextMenu(builder: builder)
        
        addContextMenu(menu)
        
        return menu
        
    }
    
}
