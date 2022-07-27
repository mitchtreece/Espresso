//
//  UIBaseView.swift
//  Espresso
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UIView` subclass that provides common helper functions & properties.
open class UIBaseView: UIView, UserInterfaceStyleAdaptable {
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupView()
        
    }
    
    /// Setup function called upon view construction.
    /// Override this function to setup & customize the view.
    open func setupView() {
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
