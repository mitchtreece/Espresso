//
//  UIContextMenu+Item.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import Foundation

public extension UIContextMenu {
    
    enum Item {
        
        case action(title: String,
                    subtitle: String? = nil,
                    image: UIImage? = nil,
                    identifier: String? = nil,
                    description: String? = nil,
                    attributes: UIMenuElement.Attributes = [],
                    state: UIMenuElement.State = .off,
                    action: UIActionHandler)
        
        case group(title: String,
                   subtitle: String? = nil,
                   image: UIImage? = nil,
                   identifier: String? = nil,
                   options: UIMenu.Options = [],
                   children: [Item])
        
        internal func menuItem() -> ContextMenuItem {
            
            switch self {
            case .action(let title,
                         let subtitle,
                         let image,
                         let identifier,
                         let description,
                         let attributes,
                         let state,
                         let action):
                
                return ContextMenuActionItem(
                    title: title,
                    subtitle: subtitle,
                    image: image,
                    identifier: identifier,
                    description: description,
                    attributes: attributes,
                    state: state,
                    action: action
                )
                
            case .group(let title,
                        let subtitle,
                        let image,
                        let identifier,
                        let options,
                        let children):
                
                return ContextMenuGroupItem(
                    title: title,
                    subtitle: subtitle,
                    image: image,
                    identifier: identifier,
                    options: options,
                    children: children.map { $0.menuItem() }
                )
                
            }
            
        }
        
    }
    
}
