//
//  ContextMenuActionBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public struct ContextMenuActionBuilder: Builder {
    
    public typealias BuildType = ContextMenuElement
    
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    public var description: String?
    public var attributes: UIMenuElement.Attributes?
    public var state: UIMenuElement.State?
    public var action: UIActionHandler?
    
    internal init() {
        //
    }
        
    public func build() -> ContextMenuElement {
        
        return UIContextMenuAction(
            title: self.title ?? "",
            subtitle: self.subtitle,
            image: self.image,
            identifier: self.identifier,
            description: self.description,
            attributes: self.attributes ?? [],
            state: self.state ?? .off,
            action: self.action ?? { _ in }
        )
        
    }
    
}
