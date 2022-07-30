//
//  ContextMenuItem.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

public protocol ContextMenuItem {
    
    var title: String { get }
    var subtitle: String? { get }
    var image: UIImage? { get }
    var identifier: String? { get }
    
    func menuElement() -> UIMenuElement
    
}
