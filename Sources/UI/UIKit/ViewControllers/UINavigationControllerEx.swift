//
//  UIBaseNavigationController.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

#if canImport(UIKit)

import UIKit
import Espresso

/// An extended `UINavigationController` subclass
/// that provides common helper functions & properties.
open class UINavigationControllerEx: UINavigationController,
                                     UIViewControllerCommon,
                                     UIViewControllerLifecycle,
                                     UIViewControllerAppearance,
                                     UIKeyboardObserving {
    
    // MARK: Publishers
    
    public var onViewDidLoad: GuaranteePublisher<Void> {
        return self._viewDidLoad.asAny()
    }
    
    public var onViewWillAppear: GuaranteePublisher<Bool> {
        return self._viewWillAppear.asAny()
    }
    
    public var onViewIsAppearing: GuaranteePublisher<Bool> {
        return self._viewIsAppearing.asAny()
    }
    
    public var onViewWillLayoutSubviews: GuaranteePublisher<Void> {
        return self._viewWillLayoutSubviews.asAny()
    }

    public var onViewDidLayoutSubviews: GuaranteePublisher<Void> {
        return self._viewDidLayoutSubviews.asAny()
    }

    public var onViewDidLoadGeometry: GuaranteePublisher<Void> {
        return self._viewDidLoadGeometry.asAny()
    }

    public var onViewDidUpdateGeometry: GuaranteePublisher<Bool> {
        return self._viewDidUpdateGeomtery.asAny()
    }
    
    public var onViewDidAppear: GuaranteePublisher<Bool> {
        return self._viewDidAppear.asAny()
    }
    
    public var onViewWillDisappear: GuaranteePublisher<Bool> {
        return self._viewWillDisappear.asAny()
    }
    
    public var onViewDidDisappear: GuaranteePublisher<Bool> {
        return self._viewDidDisappear.asAny()
    }
    
    public var onDidRecieveMemoryWarning: GuaranteePublisher<Void> {
        return self._didReceiveMemoryWarning.asAny()
    }
    
    public private(set) var isFirstAppearance: Bool = true
    public private(set) var isKeyboardVisible: Bool = false
    
    public var prefersNavigationBarHidden: Bool = false {
        didSet {
            if !self.isFirstAppearance {
                updateNavBarVisibility()
            }
        }
    }
    
    public var isSwipeBackGestureEnabled: Bool {
        get { return self.swipeBackDelegate.isGestureEnabled }
        set { self.swipeBackDelegate.isGestureEnabled = newValue }
    }
    
    public var modalStyle: UIModalStyle {
        get { return .init(modalPresentationStyle: self.modalPresentationStyle) }
        set { self.modalPresentationStyle = newValue.asModalPresentationStyle() }
    }
    
    public var isInModalSheetPresentation: Bool {
        return self.modalStyle.isModalSheet
    }
    
    public var onKeyboardWillShow: GuaranteePublisher<UIKeyboardAnimation> {
        return self._keyboardWillShow.asAny()
    }
    
    public var onKeyboardDidShow: GuaranteePublisher<UIKeyboardAnimation> {
        return self._keyboardDidShow.asAny()
    }
    
    public var onKeyboardWillChangeFrame: GuaranteePublisher<UIKeyboardAnimation> {
        return self._keyboardWillChangeFrame.asAny()
    }
    
    public var onKeyboardDidChangeFrame: GuaranteePublisher<UIKeyboardAnimation> {
        return self._keyboardDidChangeFrame.asAny()
    }
    
    public var onKeyboardWillHide: GuaranteePublisher<UIKeyboardAnimation> {
        return self._keyboardWillHide.asAny()
    }
    
    public var onKeyboardDidHide: GuaranteePublisher<UIKeyboardAnimation> {
        return self._keyboardDidHide.asAny()
    }

    @available(iOS 13, *)
    public var isInteractiveModalDismissEnabled: Bool {
        get { return !self.isModalInPresentation }
        set { self.isModalInPresentation = !newValue }
    }
    
    public private(set) var isBinded: Bool = false
    public private(set) var isComponentBinded: Bool = false

    public var bag = CancellableBag()
    public var componentBag = CancellableBag()
    
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
    
    private var _keyboardWillShow = GuaranteePassthroughSubject<UIKeyboardAnimation>()
    private var _keyboardDidShow = GuaranteePassthroughSubject<UIKeyboardAnimation>()
    private var _keyboardWillChangeFrame = GuaranteePassthroughSubject<UIKeyboardAnimation>()
    private var _keyboardDidChangeFrame = GuaranteePassthroughSubject<UIKeyboardAnimation>()
    private var _keyboardWillHide = GuaranteePassthroughSubject<UIKeyboardAnimation>()
    private var _keyboardDidHide = GuaranteePassthroughSubject<UIKeyboardAnimation>()

    // MARK: Child Overrides
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    open override var childForHomeIndicatorAutoHidden: UIViewController? {
        return self.topViewController
    }

    open override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        return self.topViewController
    }
    
    private let swipeBackDelegate = UIInteractiveSwipeBackDelegate()
    private var traitObserver: AnyObject?
    private var keyboardBag = CancellableBag()

    // MARK: Functions
    
    deinit {
        cleanup()
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
        self._viewDidLoad.send()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        
        if self.isFirstAppearance {
            updateNavBarVisibility(animated)
        }
        
        bindKeyboard()
        
        if !self.isBinded {
                   
            bind()
            self.isBinded = true
            
        }
        
        if !self.isComponentBinded {
            
            bindComponents()
            self.isComponentBinded = true
            
        }
        
        self._viewWillAppear.send(animated)
        
        if self.isFirstAppearance {
            
            DispatchQueue.main.async { [weak self] in
                self?.viewDidLoadGeometry()
            }
            
        }

    }
    
    open override func viewIsAppearing(_ animated: Bool) {

        super.viewIsAppearing(animated)
        self._viewIsAppearing.send(animated)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewDidUpdateGeomtery(animated)
        }

    }
    
    open override func viewWillLayoutSubviews() {

        super.viewWillLayoutSubviews()
        self._viewWillLayoutSubviews.send()

    }

    open override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        self._viewDidLayoutSubviews.send()

    }
    
    open func viewDidLoadGeometry() {
        self._viewDidLoadGeometry.send()
    }
    
    open func viewDidUpdateGeomtery(_ animated: Bool) {
        self._viewDidUpdateGeomtery.send(animated)
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
        unbindKeyboard()
        self._viewDidDisappear.send(animated)

    }

    open override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
        self._didReceiveMemoryWarning.send()

    }
    
    // MARK: Binders
    
    open func bind() {
        self.bag.removeAll()
    }
    
    open func bindComponents() {
        self.componentBag.removeAll()
    }
    
    // MARK: User Interface
    
    @objc open func userInterfaceStyleDidChange() {}
        
    @available(iOS, deprecated: 17, message: "Use `registerForTraitChanges(traits:action:)` instead")
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        if #unavailable(iOS 17) {
            
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                userInterfaceStyleDidChange()
            }
            
        }

    }
    
    // MARK: Keyboard
    
    open func keyboardWillShow(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = true
    }

    open func keyboardDidShow(_ animation: UIKeyboardAnimation) {}
    
    open func keyboardWillChangeFrame(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = true
    }
    
    open func keyboardDidChangeFrame(_ animation: UIKeyboardAnimation) {}
    
    open func keyboardWillHide(_ animation: UIKeyboardAnimation) {
        self.isKeyboardVisible = false
    }
    
    open func keyboardDidHide(_ animation: UIKeyboardAnimation) {}

    // MARK: Private
    
    private func setup() {
        
        self.swipeBackDelegate.originalGestureDelegate = self.interactivePopGestureRecognizer?.delegate
        self.swipeBackDelegate.navigationController = self
        self.interactivePopGestureRecognizer?.delegate = self.swipeBackDelegate

        if #available(iOS 17, *) {

            self.traitObserver = registerForTraitChanges(
                [UITraitUserInterfaceStyle.self],
                action: #selector(userInterfaceStyleDidChange)
            )

        }
        
    }
    
    private func cleanup() {
        
        if #available(iOS 17, *) {

            if let observer = self.traitObserver as? UITraitChangeRegistration {
                unregisterForTraitChanges(observer)
            }

        }
        
    }
    
    private func updateNavBarVisibility(_ animated: Bool = true) {
        
        setNavigationBarHidden(
            self.prefersNavigationBarHidden,
            animated: animated
        )
        
    }
    
    private func bindKeyboard() {
        
        unbindKeyboard()
        
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
    
    private func unbindKeyboard() {
        self.keyboardBag.removeAll()
    }
    
}

#endif
