//
//  ContextMenuActionItem.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

public struct UIContextMenuAction: ContextMenuAction {
    
    public var title: String
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    
    public var description: String?
    public var attributes: UIMenuElement.Attributes
    public var state: UIMenuElement.State
    public var action: UIActionHandler

    public init(title: String,
                subtitle: String?,
                image: UIImage?,
                identifier: String?,
                description: String?,
                attributes: UIMenuElement.Attributes,
                state: UIMenuElement.State,
                action: @escaping UIActionHandler) {

        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.identifier = identifier
        
        self.description = description
        self.attributes = attributes
        self.state = state
        self.action = action

    }
    
    public func buildElement() -> UIMenuElement {
     
        let action = UIAction(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIAction.Identifier(self.identifier!) : nil,
            discoverabilityTitle: self.description,
            attributes: self.attributes,
            state: self.state,
            handler: self.action
        )

        if #available(iOS 15, *) {
            action.subtitle = self.subtitle
        }

        return action
        
    }
    
}
