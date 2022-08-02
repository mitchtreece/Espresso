//
//  ContextMenuActionItem.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

/// A context menu action.
public struct UIContextMenuAction: ContextMenuAction {
        
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    
    public var attributes: UIMenuElement.Attributes
    public var state: UIMenuElement.State
    public var action: UIActionHandler

    /// Initializes a context menu action.
    ///
    /// - parameter title: The action's title.
    /// - parameter subtitle: The action's subtitle.
    /// - parameter image: The action's image.
    /// - parameter identifier: The action's identifier.
    /// - parameter attributes: The action's attributes.
    /// - parameter state: The action's state.
    /// - parameter image: The action's action handler.
    public init(title: String,
                subtitle: String? = nil,
                image: UIImage? = nil,
                identifier: String? = nil,
                attributes: UIMenuElement.Attributes = [],
                state: UIMenuElement.State = .off,
                action: @escaping UIActionHandler) {

        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.identifier = identifier
        
        self.attributes = attributes
        self.state = state
        self.action = action

    }
    
    public func buildMenuElement() -> UIMenuElement {
     
        let action = UIAction(
            title: self.title ?? "",
            image: self.image,
            identifier: (self.identifier != nil) ? UIAction.Identifier(self.identifier!) : nil,
            discoverabilityTitle: self.subtitle,
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
