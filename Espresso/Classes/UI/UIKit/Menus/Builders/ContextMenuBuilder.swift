//
//  ContextMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public struct ContextMenuBuilder: ContextMenuElementBuilder, ContextMenuBuildable {
        
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elements: [ContextMenuElement] = []
    
    internal init() {
        //
    }
    
    internal func build() -> ContextMenuElement {
        
        return UIContextMenuSubMenu(
            title: self.title ?? "",
            subtitle: self.subtitle,
            image: self.image,
            identifier: self.identifier,
            options: self.options,
            elements: self.elements
        )
        
    }
    
}
