//
//  UIBaseTableViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UITableViewCell` subclass that provides
/// common helper functions & properties.
open class UIBaseTableViewCell: UITableViewCell,
                                UIUserInterfaceStyleAdaptable {
    
    public override init(style: UITableViewCell.CellStyle,
                         reuseIdentifier: String?) {
        
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        willLoadLayout()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        willLoadLayout()
        
    }
    
    /// Called when the view is about to load its layout.
    ///
    /// This function is called from `init(frame:)` *or* `init(coder:)`.
    /// Subview frames are not guaranteed to have accurate values at this point.
    open func willLoadLayout() {
        
        DispatchQueue.main.async { [weak self] in
            self?.didLoadLayout()
        }
        
    }
    
    /// Called when the view finishes loading its layout.
    /// Override this function to provide custom setup logic that depends
    /// on subview frames, positions, etc.
    ///
    /// This function is scheduled on the main-thread from `willLoadLayout`.
    /// Subview frames should have accurate values at this point.
    open func didLoadLayout() {
        // Override
    }
    
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
