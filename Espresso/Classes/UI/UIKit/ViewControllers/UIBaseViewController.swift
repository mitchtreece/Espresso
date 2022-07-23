//
//  UIBaseViewController.swift
//  Director
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UIViewController` subclass that provides common helper functions & properties.
open class UIBaseViewController: UIViewController {
    
    /// Flag indicating if this is the view controller's first appearance.
    ///
    /// This will only be `true` until the view controller's
    /// `viewDidAppear(_:)` function is called for the first time.
    public private(set) var isFirstAppearance: Bool = true
    
    /// Flag indicating if the view controller should hide it's
    /// navigation bar on appearance; _defaults to false_.
    open var hidesNavigationBarOnAppearance: Bool {
        return false
    }
    
    /// The view controller's modal style.
    public var modalStyle: ModalStyle {
        get {
            return ModalStyle(modalPresentationStyle: self.modalPresentationStyle)
        }
        set {
            self.modalPresentationStyle = newValue.asModalPresentationStyle()
        }
    }
    
    public var isInModalCardPresentation: Bool {
                
        guard let nav = self.navigationController else {
            return self.modalStyle.isModalCard
        }
        
        return ModalStyle(modalPresentationStyle: nav.modalPresentationStyle).isModalCard
        
    }
    
    public var userInterfaceStyle: UIUserInterfaceStyle {
        return self.traitCollection.userInterfaceStyle
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(
            self.hidesNavigationBarOnAppearance,
            animated: true
        )
                
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.isFirstAppearance = false
        
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
    /// Override this function to update your interface as needed.
    open func userInterfaceStyleDidChange() {
        // Override
    }
    
}
