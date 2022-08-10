//
//  BaseViewController.swift
//  Director
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit

/// `UIBaseViewController` subclass that provides common helper functions & properties.
open class UIBaseViewController: UIViewController, UserInterfaceStyleAdaptable {
    
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
    
    /// Flag indicating if tapping the view controller's view should call
    /// `resignFirstResponder()` on all editable subviews; _defaults to false_.
    open var endsEditingOnTap: Bool {
        return false
    }
    
    /// Flag indicating if ending editing should be done forcefully or not; _defaults to false_.
    ///
    /// This flag is ignored if `endsEditingOnTap` is `false`.
    open var endsEditingForcefully: Bool {
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
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addTapGesture { [weak self] _ in
            
            guard let self = self else { return }
            guard self.endsEditingOnTap else { return }
            
            self.view
                .endEditing(self.endsEditingForcefully)
            
        }
        
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
