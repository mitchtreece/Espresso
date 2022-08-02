//
//  UIMenuAction.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public struct MenuAction: MenuActionElement {
    
    public typealias MenuElementType = UIAction
    
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    public var attributes: UIMenuElement.Attributes = []
    public var state: UIMenuElement.State = .off
    public var action: UIActionHandler = { _ in }
    
    /// Initializes a menu action.
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
    
    internal init(builder: MenuActionBuilder) {
        
        self.init(
            title: builder.title,
            subtitle: builder.subtitle,
            image: builder.image,
            identifier: builder.identifier,
            attributes: builder.attributes,
            state: builder.state,
            action: builder.action ?? { _ in }
        )
        
    }
    
    public init(_ block: (inout MenuActionBuilder)->()) {
        
        var builder = MenuActionBuilder()
        
        block(&builder)
        
        self.init(builder: builder)
        
    }
    
    public func build() -> UIAction {
     
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
