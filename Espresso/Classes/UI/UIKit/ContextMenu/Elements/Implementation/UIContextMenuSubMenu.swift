//
//  UIContextMenuSubMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

/// A context menu sub-menu.
public struct UIContextMenuSubMenu: ContextMenu {
        
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    
    public var options: UIMenu.Options
    public var elementSize: UIMenuElementSize
    public var elements: [ContextMenuElement]

    /// Initializes a context menu sub-menu.
    ///
    /// - parameter title: The menu's title.
    /// - parameter subtitle: The menu's subtitle.
    /// - parameter image: The menu's image.
    /// - parameter identifier: The menu's identifier.
    /// - parameter options: The menu's options.
    /// - parameter elementSize: The menu's element size.
    /// - parameter elements: The menu's elements.
    public init(title: String,
                subtitle: String? = nil,
                image: UIImage? = nil,
                identifier: String? = nil,
                options: UIMenu.Options = [],
                elementSize: UIMenuElementSize = .large,
                elements: [ContextMenuElement]) {

        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.identifier = identifier
        
        self.options = options
        self.elementSize = elementSize
        self.elements = elements

    }
    
    public func buildMenuElement() -> UIMenuElement {

        let menu = UIMenu(
            title: self.title ?? "",
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.elements.map { $0.buildMenuElement() }
        )

        if #available(iOS 15, *) {
            menu.subtitle = self.subtitle
        }
        
        if #available(iOS 16, *) {
            menu.preferredElementSize = self.elementSize.size
        }

        return menu
        
    }
    
}
