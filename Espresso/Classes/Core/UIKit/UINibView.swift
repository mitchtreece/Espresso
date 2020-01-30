//
//  UINibView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/5/18.
//

import UIKit

/**
 `UIView` subclass that loads it's contents from a nib.
 */
open class UINibView: UIBaseView {
    
    /**
     Initializes a new instance of the view from a nib. If no name is provided, the class name will be used.
     If no bundle name is provided, the main bundle will be used.
     
     - Parameter name: The nib's name.
     - Parameter bundleName: The bundle to load the nib from.
     - Returns: A typed nib-loaded view instance.
     */
    public static func initFromNib(named name: String? = nil, inBundle bundleName: String? = nil) -> Self {
        
        return self.loadFromNib(
            name: name,
            bundleName: bundleName
        )
        
    }
    
}
