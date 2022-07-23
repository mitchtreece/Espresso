//
//  UIContextMenuItem.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

public protocol UIContextMenuItem {
    
    var title: String  { get }
    var image: UIImage? { get }
    var identifier: String? { get }
    var element: UIMenuElement? { get }
    
}
