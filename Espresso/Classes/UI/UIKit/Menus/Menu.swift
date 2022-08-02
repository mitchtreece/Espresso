//
//  Menu.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public struct Menu: MenuMenuElement {
    
    public typealias MenuElementType = UIMenu
    
    /// Representation of the various sizes of menu elements.
    public enum ElementSize {
        
        /// A small menu element size.
        case small
        
        /// A medium menu element size.
        case medium
        
        /// A large menu element size.
        case large
        
        /// Gets the `UIKit` menu element size.
        @available(iOS 16, *)
        public func asMenuElementSize() -> UIMenu.ElementSize {
            
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
            
        }
        
    }
        
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elementSize: ElementSize = .large
    public var elements: [any MenuElement] = []
    
    /// Initializes a menu.
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
                elementSize: ElementSize = .large,
                elements: [any MenuElement]) {

        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.identifier = identifier
        
        self.options = options
        self.elementSize = elementSize
        self.elements = elements

    }
    
    internal init(builder: MenuBuilder) {
        
        self.init(
            title: builder.title,
            subtitle: builder.subtitle,
            image: builder.image,
            identifier: builder.identifier,
            options: builder.options,
            elementSize: builder.elementSize,
            elements: builder.elements
        )
        
    }
    
    public init(_ block: (inout MenuBuilder)->()) {
        
        var builder = MenuBuilder()
        
        block(&builder)
        
        self.init(builder: builder)
        
    }
    
    public func build() -> UIMenu {

        let menu = UIMenu(
            title: self.title ?? "",
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.elements.map { $0.build() }
        )
        
        if #available(iOS 15, *) {
            menu.subtitle = self.subtitle
        }
        
        if #available(iOS 16, *) {
            menu.preferredElementSize = self.elementSize.asMenuElementSize()
        }

        return menu
        
    }
    
}
