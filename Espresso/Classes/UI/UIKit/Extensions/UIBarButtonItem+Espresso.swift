//
//  UIBarButtonItem+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Foundation

public extension UIBarButtonItem {
 
    func addTarget(_ target: AnyObject?,
                   action: Selector?) {
        
        self.target = target
        self.action = action
        
    }
    
}
