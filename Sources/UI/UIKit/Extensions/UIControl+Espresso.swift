//
//  UIControl+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import UIKit

public extension UIControl.Event {
    
    static var defaultValueEvents: UIControl.Event {
        
        return [
            .allEditingEvents,
            .valueChanged
        ]
        
    }
    
}
