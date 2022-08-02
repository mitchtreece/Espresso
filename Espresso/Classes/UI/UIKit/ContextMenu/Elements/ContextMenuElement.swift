//
//  ContextMenuElement.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

/// Protocol describing the attributes of a context menu element.
public protocol ContextMenuElement {
    
    /// The element's title.
    var title: String? { get set }
    
    /// The element's subtitle.
    var subtitle: String? { get set }
    
    /// The element's image.
    var image: UIImage? { get set }
    
    /// The element's identifier.
    var identifier: String? { get set }
    
    /// Builds a menu element.
    /// - returns: A new `UIMenuElement`.
    func buildMenuElement() -> UIMenuElement
    
}
