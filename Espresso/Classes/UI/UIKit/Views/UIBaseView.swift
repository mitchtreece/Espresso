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
        willSetup()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        willSetup()
        
    }
    
    /// Called when the view is about to perform setup actions.
    /// Override this function to provide custom setup logic.
    ///
    /// This function is called from `init(frame:)` *or* `init(coder:)`.
    /// View frames are not guaranteed to have accurate values at this point.
    open func willSetup() {
        
        DispatchQueue.main.async { [weak self] in
            self?.didSetup()
        }
        
    }
    
    /// Called when the view finishes setup actions.
    /// Override this function to provide custom frame setup logic.
    ///
    /// This function is scheduled on the main-thread from `willSetup`.
    /// View frames should have accurate values at this point.
    open func didSetup() {
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
