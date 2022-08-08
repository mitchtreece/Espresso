//
//  MenuTarget.swift
//  Espresso
//
//  Created by Mitch Treece on 8/7/22.
//

import UIKit

public protocol MenuTarget: AnyObject {
    
    var menu: UIMenu? { get set }
    
}

@available(iOS 14, *)
extension UIButton: MenuTarget {}

@available(iOS 14, *)
extension UIBarButtonItem: MenuTarget {}

public extension MenuTarget {
    
    func addMenu(_ menu: UIMenu) {
        self.menu = menu
    }
    
    @discardableResult
    func addMenu(builder: (inout UIMenuBuildable)->()) -> UIMenu {
        
        var buildable: UIMenuBuildable = UIMenuBuilder()
        builder(&buildable)
        
        let menu = (buildable as! UIMenuBuilder).build()
        addMenu(menu)
        
        return menu
        
    }
    
    func removeMenu(_ menu: UIMenu) {
    
        guard self.menu?.identifier == menu.identifier else { return }
        self.menu = nil
        
    }
    
}
