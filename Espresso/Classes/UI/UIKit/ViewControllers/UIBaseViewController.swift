//
//  BaseViewController.swift
//  Director
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit
import Combine

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
    /// view is about to perform setup actions.
    public var viewWillSetupPublisher: GuaranteePublisher<Void> {
        return self._viewWillSetup.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view finishes setup actions.
    public var viewDidSetupPublisher: GuaranteePublisher<Void> {
        return self._viewDidSetup.eraseToAnyPublisher()
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
    
    /// Flag indicating if the view controller should hide it's
    /// navigation bar on appearance; _defaults to false_.
    open var prefersNavigationBarHidden: Bool {
        return false
    }
    
    /// Flag indicating if this is the view controller's first appearance.
    ///
    /// This will only be `true` until the view controller's
    /// `viewDidAppear(_:)` function is called for the first time.
    public private(set) var isFirstAppearance: Bool = true
    
    /// The view controller's modal style.
    public var modalStyle: UIModalStyle {
        get {
            return UIModalStyle(modalPresentationStyle: self.modalPresentationStyle)
        }
        set {
            self.modalPresentationStyle = newValue.asModalPresentationStyle()
        }
    }
    
    /// Flag indicating if the view controller has a modal-sheet presentation style.
    public var isInModalSheetPresentation: Bool {
                
        guard let nav = self.navigationController else {
            return self.modalStyle.isModalSheet
        }
        
        return UIModalStyle(modalPresentationStyle: nav.modalPresentationStyle).isModalSheet
        
    }
    
    /// Flag indicating if the view controller enforces modal-behavior,
    /// or supports interactive dismissal.
    @available(iOS 13, *)
    public var isInteractiveModalDismissEnabled: Bool {
        get { return !self.isModalInPresentation }
        set { self.isModalInPresentation = !newValue }
    }
    
    private var _viewDidLoad = TriggerPublisher()
    private var _viewWillSetup = TriggerPublisher()
    private var _viewDidSetup = TriggerPublisher()
    private var _viewWillAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewWillDisappear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidDisappear = GuaranteePassthroughSubject<Bool>()
    private var _didReceiveMemoryWarning = TriggerPublisher()
    
    private var keyboardBag = CancellableBag()
 
    open override func viewDidLoad() {
        
        super.viewDidLoad()
                
        self._viewDidLoad.send()
        
        viewWillSetup()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(
            self.prefersNavigationBarHidden,
            animated: true
        )
        
        bindKeyboardEvents()
        
        self._viewWillAppear.send(animated)
                
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.isFirstAppearance = false
        
        self._viewDidAppear.send(animated)
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self._viewWillDisappear.send(animated)
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        unbindKeyboardEvents()
        
        self._viewDidDisappear.send(animated)
        
    }
    
    open override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        self._didReceiveMemoryWarning.send()
        
    }
    
    /// Called when the view controller's view is about to perform setup actions.
    /// Override this function to provide custom setup logic.
    ///
    /// This function is called from `viewDidLoad`.
    /// View frames are not guaranteed to have accurate values at this point.
    open func viewWillSetup() {
        
        self._viewWillSetup.send()
        
        DispatchQueue.main.async { [weak self] in
            self?.viewDidSetup()
        }
        
    }
    
    /// Called when the view controller's view finishes setup actions.
    /// Override this function to provide custom frame setup logic.
    ///
    /// This function is scheduled on the main-thread from `viewWillSetup`.
    /// View frames should have accurate values at this point.
    open func viewDidSetup() {
        self._viewDidSetup.send()
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
    open func keyboardDidShow(_ animation: UIKeyboardAnimation) {}
    
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
    open func keyboardDidHide(_ animation: UIKeyboardAnimation) {}
    
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
        self.keyboardBag.removeAll()
    }
    
}
