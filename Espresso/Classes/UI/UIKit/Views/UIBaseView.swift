//
//  UIBaseView.swift
//  Espresso
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UIView` subclass that provides common helper functions & properties.
open class UIBaseView: UIView, UIUserInterfaceStyleAdaptable {
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
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
