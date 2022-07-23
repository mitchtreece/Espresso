//
//  UIBaseCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UICollectionViewCell` subclass that provides common helper functions & properties.
open class UIBaseCollectionViewCell: UICollectionViewCell {
    
    public var userInterfaceStyle: UIUserInterfaceStyle {
        return self.traitCollection.userInterfaceStyle
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        let previousInterfaceStyle = previousTraitCollection?.userInterfaceStyle
        let newInterfaceStyle = self.traitCollection.userInterfaceStyle
        
        if newInterfaceStyle != previousInterfaceStyle {
            userInterfaceStyleDidChange()
        }
        
    }
    
    /// Called when the system's `UIUserInterfaceStyle` changes.
    /// Override this function to update your cell as needed.
    open func userInterfaceStyleDidChange() {
        // Override
    }
    
}
