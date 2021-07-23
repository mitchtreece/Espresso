//
//  UIContextMenuActionItem.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

@available(iOS 13, *)
public struct UIContextMenuActionItem: UIContextMenuItem {
    
    public let title: String
    public let image: UIImage?
    public let identifier: String?
    public let description: String?
    public let state: UIMenuElement.State
    
    public var element: UIMenuElement? {
        
        return UIAction(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIAction.Identifier(self.identifier!) : nil,
            discoverabilityTitle: self.description,
            attributes: self.attributes,
            state: self.state,
            handler: self.action
        )
        
    }
    
    private let attributes: UIMenuElement.Attributes
    private let action: UIActionHandler
    
    public init(title: String,
                image: UIImage?,
                identifier: String? = nil,
                description: String? = nil,
                state: UIMenuElement.State = .off,
                attributes: UIMenuElement.Attributes = [],
                action: @escaping UIActionHandler) {
        
        self.title = title
        self.image = image
        self.identifier = identifier
        self.description = description
        self.state = state
        self.attributes = attributes
        self.action = action
        
    }
    
}
