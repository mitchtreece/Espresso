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
    public var modalStyle: UIModalStyle {
        get {
            return UIModalStyle(presentationStyle: self.modalPresentationStyle)
        }
        set {
            self.modalPresentationStyle = newValue.presentationStyle
        }
    }
    
    public var isInModalSheetPresentation: Bool {
        
        guard #available(iOS 13, *) else { return false }
        
        guard let nav = self.navigationController else {
            return self.modalStyle.isModalSheet
        }
        
        return UIModalStyle(presentationStyle: nav.modalPresentationStyle).isModalSheet
        
    }
    
    /// Flag indicating if the view controller enforces modal-behavior,
    /// or supports interactive dismissal.
    @available(iOS 13, *)
    public var isInteractiveDismissEnabled: Bool {
        get { return !self.isModalInPresentation }
        set { self.isModalInPresentation = !newValue }
    }
    
    /// The view controller's user interface style.
    @available(iOS 12, *)
    public var userInterfaceStyle: UIUserInterfaceStyle {
        return self.traitCollection.userInterfaceStyle
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(
            self.hidesNavigationBarOnAppearance,
            animated: true
        )

        addKeyboardObservers()
                
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.isFirstAppearance = false
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
        
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
    
    /// Called when the keyboard is about to be presented.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillShow(_ animation: KeyboardAnimation) {}
    
    /// Called when the keyboard finishes presenting.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidShow(_ animation: KeyboardAnimation) {}
    
    /// Called when the keyboard's frame is about to change.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillChangeFrame(_ animation: KeyboardAnimation) {}
    
    /// Called when the keyboard's frame finishes changing.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidChangeFrame(_ animation: KeyboardAnimation) {}
    
    /// Called when the keyboard is about to be dismissed.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillHide(_ animation: KeyboardAnimation) {}
    
    
    /// Called when the keyboard finishes dismissing.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidHide(_ animation: KeyboardAnimation) {}
    
    // MARK: Private
    
    private func addKeyboardObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardDidShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardDidChangeFrame),
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
        
    }
    
    private func removeKeyboardObservers() {
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
        
    }
    
    @objc private func _keyboardWillShow(_ notification: Notification) {
        
        guard let animation = KeyboardAnimation(notification: notification) else { return }
        keyboardWillShow(animation)
        
    }
    
    @objc private func _keyboardDidShow(_ notification: Notification) {
        
        guard let animation = KeyboardAnimation(notification: notification) else { return }
        keyboardDidShow(animation)
        
    }
    
    @objc private func _keyboardWillChangeFrame(_ notification: Notification) {
        
        guard let animation = KeyboardAnimation(notification: notification) else { return }
        keyboardWillChangeFrame(animation)
        
    }
    
    @objc private func _keyboardDidChangeFrame(_ notification: Notification) {
        
        guard let animation = KeyboardAnimation(notification: notification) else { return }
        keyboardDidChangeFrame(animation)
        
    }
    
    @objc private func _keyboardWillHide(_ notification: Notification) {
        
        guard let animation = KeyboardAnimation(notification: notification) else { return }
        keyboardWillHide(animation)
        
    }
    
    @objc private func _keyboardDidHide(_ notification: Notification) {
        
        guard let animation = KeyboardAnimation(notification: notification) else { return }
        keyboardDidHide(animation)
        
    }
    
}
