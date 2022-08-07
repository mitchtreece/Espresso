//
//  MenuTarget.swift
//  Espresso
//
//  Created by Mitch Treece on 8/7/22.
//

import UIKit

public protocol MenuTarget {
    
    var menu: UIMenu? { get set }
    
}

@available(iOS 14, *)
extension UIButton: MenuTarget {}

@available(iOS 14, *)
extension UIBarButtonItem: MenuTarget {}

public extension MenuTarget {
    
    mutating func addMenu(_ menu: UIMenu) {
        self.menu = menu
    }
    
    @discardableResult
    mutating func addMenu(builder: (inout UIMenuBuildable)->()) -> UIMenu {
        
        var buildable: UIMenuBuildable = UIMenuBuilder()
        builder(&buildable)
        
        let menu = (buildable as! UIMenuBuilder).build()
        addMenu(menu)
        
        return menu
        
    }
    
    mutating func removeMenu(_ menu: UIMenu) {
    
        guard self.menu?.identifier == menu.identifier else { return }
        self.menu = nil
        
    }
    
}
