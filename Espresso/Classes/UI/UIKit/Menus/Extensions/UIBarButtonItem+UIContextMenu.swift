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
    
}
