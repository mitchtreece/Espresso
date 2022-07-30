//
//  UIContextMenuSubMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

public struct UIContextMenuSubMenu: ContextMenu {
    
    public typealias BuildType = UIMenuElement
    
    public var title: String
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    
    public var options: UIMenu.Options
    public var elements: [ContextMenuElement]

    public init(title: String,
                subtitle: String?,
                image: UIImage?,
                identifier: String?,
                options: UIMenu.Options,
                elements: [ContextMenuElement]) {

        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.identifier = identifier
        
        self.options = options
        self.elements = elements

    }
    
    public func build() -> UIMenuElement {

        let menu = UIMenu(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.elements.map { $0.build() }
        )

        if #available(iOS 15, *) {
            menu.subtitle = self.subtitle
        }

        return menu
        
    }
    
}
