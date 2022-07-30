//
//  UIContextMenuGroupItem.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

public struct ContextMenuGroupItem: ContextMenuItem {
    
    public var title: String
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    
    public var options: UIMenu.Options
    public var children: [ContextMenuItem]

    public init(title: String,
                subtitle: String?,
                image: UIImage?,
                identifier: String?,
                options: UIMenu.Options,
                children: [ContextMenuItem]) {

        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.identifier = identifier
        
        self.options = options
        self.children = children

    }
    
    public func menuElement() -> UIMenuElement {
     
        let menu = UIMenu(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.children.map { $0.menuElement() }
        )

        if #available(iOS 15, *) {
            menu.subtitle = self.subtitle
        }

        return menu
        
    }
    
}
