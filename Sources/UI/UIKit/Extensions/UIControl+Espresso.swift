//
//  UIControl+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

#if canImport(UIKit)

import UIKit

public extension UIControl.Event {
    
    static var defaultValueEvents: UIControl.Event {
        
        return [
            .allEditingEvents,
            .valueChanged
        ]
        
    }
    
}

#endif
