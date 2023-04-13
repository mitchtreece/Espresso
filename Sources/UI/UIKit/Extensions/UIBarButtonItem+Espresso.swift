//
//  UIBarButtonItem+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Foundation

public extension UIBarButtonItem {
 
    /// Sets the bar button item's action target & selector.
    /// - parameter target: The action target.
    /// - parameter action: The action selector.
    func addTarget(_ target: AnyObject?,
                   action: Selector?) {
        
        self.target = target
        self.action = action
        
    }
    
}
