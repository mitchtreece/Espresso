//
//  MenuElement.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public protocol MenuElement {
    
    associatedtype ElementType: UIMenuElement
    
    func build() -> ElementType
    
}

public protocol IdentifiableMenuElement: MenuElement {
 
    var title: String? { get set }
    var identifier: String? { get set }
    
}

public protocol DetailedMenuElement: IdentifiableMenuElement {
 
    var subtitle: String? { get set }
    var image: UIImage? { get set }
    
}

public protocol BaseMenuMenuElement: MenuElement {
    
    var options: UIMenu.Options { get set }
    var elementSize: Menu.ElementSize { get set }
    
}

//public protocol DeferredMenuElement: MenuElement {
//    // TODO
//}
