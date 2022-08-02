//
//  MenuChildMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

/// A menu builder.
public struct MenuBuilder: MenuElementBuilder, MenuElementContainer {
            
    typealias ElementType = Menu
    
    /// The menu's title.
    public var title: String = .empty
    
    /// The menu's subtitle.
    public var subtitle: String?
    
    /// The menu's image.
    public var image: UIImage?
    
    /// The menu's identifier.
    public var identifier: String?
    
    /// The menu's options.
    public var options: UIMenu.Options = []
    
    /// The menu's element size.
    ///
    /// This is supported on iOS 16 and higher. This will be completely
    /// ignored if running on a device on iOS 15 or lower.
    public var elementSize: Menu.ElementSize = .large
    
    /// The menu's elements.
    public var elements: [any MenuElement] = []
    
    internal init() {
        //
    }
    
    internal func build() -> Menu {
        
        return Menu(
            title: self.title,
            subtitle: self.subtitle,
            image: self.image,
            identifier: self.identifier,
            options: self.options,
            elementSize: self.elementSize,
            elements: self.elements
        )
        
    }
    
}
