//
//  MenuActionElement.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public protocol MenuActionElement: DetailedMenuElement {
        
    var attributes: UIMenuElement.Attributes { get set }
    var state: UIMenuElement.State { get set }
    var action: UIActionHandler { get set }
    
}
