//
//  UIBaseViewController.swift
//  Director
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UIViewController` subclass that provides common helper functions & properties.
open class UIBaseViewController: UIViewController {
    
    /// The view controller's modal style.
    public var modalStyle: UIModalStyle {
        get {
            return UIModalStyle.from(presentationStyle: self.modalPresentationStyle)
        }
        set {
            self.modalPresentationStyle = newValue.presentationStyle
        }
    }
    
    public var isInModalCardPresentation: Bool {
        
        guard #available(iOS 13, *) else { return false }
        guard let nav = self.navigationController else {
            return self.modalStyle.isModalCard
        }
        
        if UIModalStyle.from(presentationStyle: nav.modalPresentationStyle).isModalCard {
            return true
        }
        
        return false
        
    }
    
    @available(iOS 12, *)
    public var userInterfaceStyle: UIUserInterfaceStyle {
        return self.traitCollection.userInterfaceStyle
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12, *) {
            
            let previousInterfaceStyle = previousTraitCollection?.userInterfaceStyle
            let newInterfaceStyle = self.traitCollection.userInterfaceStyle
            
            if newInterfaceStyle != previousInterfaceStyle {
                userInterfaceStyleDidChange()
            }
            
        }
        
    }
    
    /// Called when the system's `UIUserInterfaceStyle` changes.
    /// Override this function to update your interface as needed.
    @available(iOS 12, *)
    open func userInterfaceStyleDidChange() {
        // Override
    }
    
}
