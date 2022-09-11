//
//  UIView+KeyboardLayoutGuide.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

@available(iOS 13, *)
@available(iOS, obsoleted: 15)
public extension UIView {
    
    var keyboardLayoutGuide: KeyboardLayoutGuide {
        
        if let layoutGuide = associatedObject(forKey: "keyboardLayoutGuide") as? KeyboardLayoutGuide {
            return layoutGuide
        }
        else {
            
            let layoutGuide = KeyboardLayoutGuide(view: self)
            
            setAssociatedObject(
                layoutGuide,
                forKey: "keyboardLayoutGuide"
            )
            
            return layoutGuide
            
        }
        
    }
    
}
