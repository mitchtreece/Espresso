//
//  UIContextMenuGroupItem.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

@available(iOS 13, *)
public struct UIContextMenuGroupItem: UIContextMenuItem {
    
    public let title: String
    public let image: UIImage?
    public let identifier: String?
    
    public var element: UIMenuElement? {

        return UIMenu(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: children.compactMap { $0.element }
        )
        
    }
    
    private let options: UIMenu.Options
    private let children: [UIContextMenuItem]
    
    public init(title: String,
                image: UIImage?,
                identifier: String? = nil,
                options: UIMenu.Options = [],
                children: [UIContextMenuItem]) {
        
        self.title = title
        self.image = image
        self.identifier = identifier
        self.options = options
        self.children = children
        
    }
    
}
