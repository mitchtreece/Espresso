//
//  BaseViewController.swift
//  Director
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit
import Combine
import Espresso // Ignore warning, we need this for SPM modules

// NOTE: UIBaseViewController Lifecycle
//
// 1. viewDidLoad
// 2. viewWillLoadLayout
// 3. viewWillAppear
// 4. viewWillLayoutSubviews
// 5. viewDidLayoutSubviews
// 6. viewDidLoadLayout
// 7. viewDidAppear

/// `UIViewController` subclass that provides
/// common helper functions & properties.
open class UIBaseViewController: UIViewController,
                                 UIUserInterfaceStyleAdaptable {
    
    /// A publisher that sends when the view controller's
    /// view finishes loading.
    public var viewDidLoadPublisher: GuaranteePublisher<Void> {
        return self._viewDidLoad.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view is about to load its layout.
    public var viewWillLoadLayoutPublisher: GuaranteePublisher<Void> {
        return self._viewWillLoadLayout.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view finishes loading its layout.
    public var viewDidLoadLayoutPublisher: GuaranteePublisher<Void> {
        return self._viewDidLoadLayout.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view is about to layout its subviews.
    public var viewWillLayoutSubviewsPublisher: GuaranteePublisher<Void> {
        return self._viewWillLayoutSubviews.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view finishes laying out its subviews.
    public var viewDidLayoutSubviewsPublisher: GuaranteePublisher<Void> {
        return self._viewDidLayoutSubviews.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view is about to appear.
    public var viewWillAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewWillAppear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view finishes appearing.
    public var viewDidAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewDidAppear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view is about to disappear.
    public var viewWillDisappearPublisher: GuaranteePublisher<Bool> {
        return self._viewWillDisappear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view finishes disappearing.
    public var viewDidDisappearPublisher: GuaranteePublisher<Bool> {
        return self._viewDidDisappear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller
    /// receives a memory warning.
    public var didRecieveMemoryWarningPublisher: GuaranteePublisher<Void> {
        return self._didReceiveMemoryWarning.eraseToAnyPublisher()
    }
    
    /// Flag indicating if the view controller should hide its
    /// navigation bar on appearance; _defaults to false_.
    open var prefersNavigationBarHidden: Bool {
        return false
    }
    
    /// Flag indicating if this is the view controller's first appearance.
    ///
    /// This will only be `true` until the view controller's
    /// `viewDidAppear(_:)` function is called for the first time.
    public private(set) var isFirstAppearance: Bool = true
    
    /// Flag indicating if the system keyboard is currently visible.
    public private(set) var isKeyboardVisible: Bool = false
    
    /// The view controller's modal style.
    public var modalStyle: UIModalStyle {
        get {
            return UIModalStyle(modalPresentationStyle: self.modalPresentationStyle)
        }
        set {
            
            self.modalPresentationStyle = newValue
                .asModalPresentationStyle()
            
        }
    }
    
    /// Flag indicating if the view controller has a modal-sheet presentation style.
    public var isInModalSheetPresentation: Bool {
                
        guard let nav = self.navigationController else {
            
            return self.modalStyle
                .isModalSheet
            
        }
        
        return UIModalStyle(
            modalPresentationStyle: nav.modalPresentationStyle
        )
        .isModalSheet
        
    }
    
    /// Flag indicating if the view controller enforces modal-behavior,
    /// or supports interactive dismissal.
    @available(iOS 13, *)
    public var isInteractiveModalDismissEnabled: Bool {
        get { return !self.isModalInPresentation }
        set { self.isModalInPresentation = !newValue }
    }
    
    private var _viewDidLoad = TriggerPublisher()
    private var _viewWillLayoutSubviews = TriggerPublisher()
    private var _viewDidLayoutSubviews = TriggerPublisher()
    private var _viewWillLoadLayout = TriggerPublisher()
    private var _viewDidLoadLayout = TriggerPublisher()
    private var _viewWillAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewWillDisappear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidDisappear = GuaranteePassthroughSubject<Bool>()
    private var _didReceiveMemoryWarning = TriggerPublisher()
    
    private var keyboardBag = CancellableBag()
 
    open override func viewDidLoad() {
                
        super.viewDidLoad()
                
        self._viewDidLoad
            .send()
        
        viewWillLoadLayout()
                
    }
    
    open override func viewWillLayoutSubviews() {
                
        super.viewWillLayoutSubviews()
        
        self._viewWillLayoutSubviews
            .send()
                
    }
    
    open override func viewDidLayoutSubviews() {
                
        super.viewDidLayoutSubviews()
        
        self._viewDidLayoutSubviews
            .send()
        
    }
    
    /// Called when the view controller's view is about to load its layout.
    ///
    /// This function is called from `viewDidLoad`.
    /// Subview frames are not guaranteed to have accurate values at this point.
    open func viewWillLoadLayout() {
        
        self._viewWillLoadLayout
            .send()
        
        self.view
            .layoutIfNeeded()
        
        DispatchQueue.main.async { [weak self] in
            self?.viewDidLoadLayout()
        }
        
    }
    
    /// Called when the view controller's view finishes loading its layout.
    /// Override this function to provide custom setup logic that depends
    /// on subview frames, positions, etc.
    ///
    /// This function is scheduled on the main-thread from `viewWillLoadLayout`.
    /// Subview frames should have accurate values at this point.
    open func viewDidLoadLayout() {
        
        self._viewDidLoadLayout
            .send()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
                
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(
            self.prefersNavigationBarHidden,
            animated: true
        )
        
        bindKeyboardEvents()
        
        self._viewWillAppear
            .send(animated)
                
    }
    
    open override func viewDidAppear(_ animated: Bool) {
                
        super.viewDidAppear(animated)
        
        self.isFirstAppearance = false
        
        self._viewDidAppear
            .send(animated)
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self._viewWillDisappear
            .send(animated)
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        unbindKeyboardEvents()
        
        self._viewDidDisappear
            .send(animated)
        
    }
    
    open override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        self._didReceiveMemoryWarning
            .send()
        
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
    
    // MARK: Keyboard
    
    /// Called when the keyboard is about to be presented.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillShow(_ animation: UIKeyboardAnimation) {}
    
    /// Called when the keyboard finishes presenting.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidShow(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = true
    }
    
    /// Called when the keyboard's frame is about to change.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillChangeFrame(_ animation: UIKeyboardAnimation) {}
    
    /// Called when the keyboard's frame finishes changing.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidChangeFrame(_ animation: UIKeyboardAnimation) {}
    
    /// Called when the keyboard is about to be dismissed.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillHide(_ animation: UIKeyboardAnimation) {}
    
    /// Called when the keyboard finishes dismissing.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidHide(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = false
    }
    
    // MARK: Private
    
    private func bindKeyboardEvents() {
        
        unbindKeyboardEvents()
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { UIKeyboardAnimation(notification: $0) }
            .sink { [weak self] in self?.keyboardWillShow($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardDidShowNotification)
            .compactMap { UIKeyboardAnimation(notification: $0) }
            .sink { [weak self] in self?.keyboardDidShow($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { UIKeyboardAnimation(notification: $0) }
            .sink { [weak self] in self?.keyboardWillChangeFrame($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardDidChangeFrameNotification)
            .compactMap { UIKeyboardAnimation(notification: $0) }
            .sink { [weak self] in self?.keyboardDidChangeFrame($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .compactMap { UIKeyboardAnimation(notification: $0) }
            .sink { [weak self] in self?.keyboardWillHide($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardDidHideNotification)
            .compactMap { UIKeyboardAnimation(notification: $0) }
            .sink { [weak self] in self?.keyboardDidHide($0) }
            .store(in: &self.keyboardBag)
        
    }
    
    private func unbindKeyboardEvents() {
        
        self.keyboardBag
            .removeAll()
        
    }
    
}
