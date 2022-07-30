//
//  ContextMenuElement.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import UIKit

public protocol ContextMenuElement {
    
    var title: String { get set }
    var subtitle: String? { get set }
    var image: UIImage? { get set }
    var identifier: String? { get set }
    
    func build() -> UIMenuElement
    
}
