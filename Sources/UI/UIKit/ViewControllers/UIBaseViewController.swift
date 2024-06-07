//
//  BaseViewController.swift
//  Director
//
//  Created by Mitch Treece on 9/16/19.
//

import UIKit
import Combine
import Espresso

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
    /// view is about to appear.
    public var viewWillAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewWillAppear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view has finished its layout pass, and is appearing.
    public var viewIsAppearingPublisher: GuaranteePublisher<Bool> {
        return self._viewIsAppearing.eraseToAnyPublisher()
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
    /// view has finished its initial layout, and has fully
    /// loaded its geometry.
    public var viewDidLoadGeometryPublisher: GuaranteePublisher<Void> {
        return self._viewDidLoadGeometry.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view controller's
    /// view has updated its layout, and has fully loaded
    /// its geometry.
    public var viewDidUpdateGeometryPublisher: GuaranteePublisher<Bool> {
        return self._viewDidUpdateGeomtery.eraseToAnyPublisher()
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
    
    /// The view controller's parent window safe-area insets.
    ///
    /// The value of this property is pulled directly from
    /// the view controller's parent `UIWindow`, which is
    /// constant and always accessible. This is useful when
    /// you need to access the inset values early in the
    /// view lifecycle. The view's property `safeAreaInsets`
    /// doesn't have valid values until later on in the view lifecycle.
    public var safeAreaWindowInsets: UIEdgeInsets {
        
        return self
            .view
            .window?
            .safeAreaInsets ?? self.view.safeAreaInsets
        
    }
    
    private var _viewDidLoad = TriggerPublisher()
    private var _viewWillAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewIsAppearing = GuaranteePassthroughSubject<Bool>()
    private var _viewWillLayoutSubviews = TriggerPublisher()
    private var _viewDidLayoutSubviews = TriggerPublisher()
    private var _viewDidLoadGeometry = TriggerPublisher()
    private var _viewDidUpdateGeomtery = GuaranteePassthroughSubject<Bool>()
    private var _viewDidAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewWillDisappear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidDisappear = GuaranteePassthroughSubject<Bool>()
    private var _didReceiveMemoryWarning = TriggerPublisher()
    
    private var traitChangeObserver: AnyObject?
    private var keyboardBag = CancellableBag()
    
    deinit {
        destroy()
    }
 
    open override func viewDidLoad() {
                
        super.viewDidLoad()
        
        setup()
                
        self._viewDidLoad
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
        
        if self.isFirstAppearance {
            
            DispatchQueue.main.async { [weak self] in
                self?.viewDidLoadGeometry()
            }
            
        }
        
    }
    
    open override func viewIsAppearing(_ animated: Bool) {
        
        super.viewIsAppearing(animated)
        
        self._viewIsAppearing
            .send(animated)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewDidUpdateGeomtery(animated)
        }
        
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
    
    /// Notifies the view controller that the system has finished
    /// loading its view's initial layout & geometry.
    ///
    /// This is scheduled from `viewWillAppear` on the view controller's
    /// first-appearance, and is only ever called once.
    ///
    /// This is scheduled from `viewWillAppear` instead of `viewDidLoad`
    /// so it can be grouped into the same appearance transaction as the other
    /// appearance-based lifecycle functions.
    open func viewDidLoadGeometry() {
        
        self._viewDidLoadGeometry
            .send()
        
    }
    
    /// Notifies the view controller that the system has finished
    /// updating its view's layout & geometry.
    ///
    /// This is scheduled from `viewIsAppearing`, and is called
    /// during each appearance cycle.
    open func viewDidUpdateGeomtery(_ animated: Bool) {
        
        self._viewDidUpdateGeomtery
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
    
    @objc
    open func userInterfaceStyleDidChange() {
        // Override
    }
    
    // MARK: Private
    
    private func setup() {
        
        if #available(iOS 17, *) {
            
            self.traitChangeObserver = registerForTraitChanges(
                [UITraitUserInterfaceStyle.self],
                action: #selector(userInterfaceStyleDidChange)
            )

        }
        
    }
    
    private func destroy() {
        
        unbindKeyboardEvents()
        
        if #available(iOS 17, *) {
            
            if let observer = self.traitChangeObserver as? UITraitChangeRegistration {
                unregisterForTraitChanges(observer)
            }
            
        }
        
    }
    
    // MARK: Traits (Deprecated - iOS 17)
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        if #unavailable(iOS 17) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                userInterfaceStyleDidChange()
            }
        }
        
    }
    
    // MARK: Keyboard
    
    /// Called when the keyboard is about to be presented.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillShow(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = true
    }
    
    /// Called when the keyboard finishes presenting.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidShow(_ animation: UIKeyboardAnimation) {}
    
    /// Called when the keyboard's frame is about to change.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillChangeFrame(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = true
    }
    
    /// Called when the keyboard's frame finishes changing.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardDidChangeFrame(_ animation: UIKeyboardAnimation) {}
    
    /// Called when the keyboard is about to be dismissed.
    /// Override this function to update your layout as needed.
    ///
    /// - parameter animation: The keyboard's animation info.
    open func keyboardWillHide(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = false
    }
    
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
        
        self.keyboardBag
            .removeAll()
        
    }
    
}
