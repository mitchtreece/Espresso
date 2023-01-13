//
//  UIBaseCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UICollectionViewCell` subclass that provides
/// common helper functions & properties.
open class UIBaseCollectionViewCell: UICollectionViewCell,
                                     UIUserInterfaceStyleAdaptable {
    
    // MARK: Traits
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)
        
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            userInterfaceStyleDidChange()
        }
        
    }
    
    open func userInterfaceStyleDidChange() {
        // Override
    }
    
}
