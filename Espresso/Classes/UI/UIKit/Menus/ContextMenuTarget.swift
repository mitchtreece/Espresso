//
//  ContextMenuTarget.swift
//  Espresso
//
//  Created by Mitch Treece on 8/1/22.
//

import UIKit

/// Protocol describing something that can be the target of context menu interactions.
public protocol ContextMenuTarget {}

extension UIView: ContextMenuTarget {}
extension UIBarButtonItem: ContextMenuTarget {}

public extension ContextMenuTarget {
    
    /// Sets the target's context menu.
    ///
    /// - parameter menu: The context menu.
    ///
    /// This function acts differently depending on the type of the receiver.
    ///
    /// For a `UIView`, this calls `addInteraction(interaction:)`
    /// and does **not** hold a strong reference to the context menu.
    ///
    /// For a `UIButton` on iOS 14 or higher, this sets the button's `menu` property.
    /// On iOS 13 and lower, this treats the button like a `UIView` and does **not**
    /// hold a strong reference to the context menu.
    ///
    /// For a `UIBarButtonItem`, this sets the item's `menu` property.
    func addContextMenu(_ menu: ContextMenu) {
        
        if let button = self as? UIButton {
            
            if #available(iOS 14, *) {
                
                addContextMenuToButton(
                    button,
                    menu: menu
                )
                
            }
            else {
                
                addContextMenuToView(
                    button,
                    menu: menu
                )
                
            }
            
        }
        else if let view = self as? UIView {
            
            addContextMenuToView(
                view,
                menu: menu
            )
            
        }
        else if let item = self as? UIBarButtonItem {

            guard #available(iOS 14, *) else { return }
            
            addContextMenuToBarButtonItem(
                item,
                menu: menu
            )
            
        }
        
    }
    
    /// Sets the target's context menu using a building closure.
    ///
    /// - parameter block: The building closure.
    /// - returns: The `UIContextMenu` set on the target.
    ///
    /// This function acts differently depending on the type of the receiver.
    ///
    /// For a `UIView`, this calls `addInteraction(interaction:)`
    /// and does **not** hold a strong reference to the context menu.
    ///
    /// For a `UIButton` on iOS 14 or higher, this sets the button's `menu` property.
    /// On iOS 13 and lower, this treats the button like a `UIView` and does **not**
    /// hold a strong reference to the context menu.
    ///
    /// For a `UIBarButtonItem`, this sets the item's `menu` property.
    @discardableResult
    func addContextMenu(builder: (inout ContextMenuBuildable)->()) -> ContextMenu {
    
        var buildable: ContextMenuBuildable = ContextMenuBuilder()
        builder(&buildable)
    
        let menu = ContextMenu(buildable: buildable)
    
        addContextMenu(menu)
    
        return menu
    
    }
    
    private func addContextMenuToView(_ view: UIView,
                                      menu: ContextMenu) {
        
        let interaction = UIContextMenuInteraction(delegate: menu)
        
        // interaction.updateVisibleMenu(...)
        // interaction.dismissMenu()
        
        view.addInteraction(interaction)
        
    }
    
    @available(iOS 14, *)
    private func addContextMenuToButton(_ button: UIButton,
                                         menu: ContextMenu) {
        
        button.menu = menu.buildMenu()
        button.showsMenuAsPrimaryAction = true
        
    }
    
    @available(iOS 14, *)
    private func addContextMenuToBarButtonItem(_ item: UIBarButtonItem,
                                               menu: ContextMenu) {
        
        item.menu = menu.buildMenu()
        
    }
    
}
