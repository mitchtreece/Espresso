//
//  UIBaseNavigationController.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit
import Espresso

/// `UINavigationController` subclass that provides
/// common helper functions & properties.
open class UIBaseNavigationController: UINavigationController,
                                       UIUserInterfaceStyleAdaptable {
    
    /// A publisher that sends when the view controller's
    /// view finishes loading.
    public var viewDidLoadPublisher: GuaranteePublisher<Void> {
        return self._viewDidLoad.eraseToAnyPublisher()
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
    /// view has finished its layout pass, and is appearing.
    public var viewIsAppearing: GuaranteePublisher<Bool> {
        return self._viewIsAppearing.eraseToAnyPublisher()
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
    
    /// Flag indicating if this is the view controller's first appearance.
    ///
    /// This will only be `true` until the view controller's
    /// `viewDidAppear(_:)` function is called for the first time.
    public private(set) var isFirstAppearance: Bool = true
    
    /// Flag indicating if the navigation controller's interactive
    /// pop gesture recognizer is enabled.
    public var isSwipeBackGestureEnabled: Bool = true {
        didSet {
            self.swipeBackDelegate.isGestureEnabled = isSwipeBackGestureEnabled
        }
    }
    
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
        return self.modalStyle.isModalSheet
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
    private var _viewWillAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewIsAppearing = GuaranteePassthroughSubject<Bool>()
    private var _viewWillDisappear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidDisappear = GuaranteePassthroughSubject<Bool>()
    private var _didReceiveMemoryWarning = TriggerPublisher()
    
    private var traitChangeObserver: AnyObject?
    private let swipeBackDelegate = UIInteractiveSwipeBackDelegate()
    
    open override var childForStatusBarStyle: UIViewController? {
        self.topViewController
    }

    open override var childForStatusBarHidden: UIViewController? {
        self.topViewController
    }

    open override var childForHomeIndicatorAutoHidden: UIViewController? {
        self.topViewController
    }

    open override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        self.topViewController
    }
    
    deinit {
        destroy()
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
        
        self._viewDidLoad
            .send()
                
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
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self._viewWillAppear.send(animated)
                
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.isFirstAppearance = false
        
        self._viewDidAppear
            .send(animated)
        
    }
    
    open override func viewIsAppearing(_ animated: Bool) {
        
        super.viewIsAppearing(animated)
        
        self._viewIsAppearing
            .send(animated)
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self._viewWillDisappear
            .send(animated)
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
                
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
        
        self.swipeBackDelegate.originalGestureDelegate = self.interactivePopGestureRecognizer?.delegate
        self.swipeBackDelegate.navigationController = self
        self.interactivePopGestureRecognizer?.delegate = self.swipeBackDelegate
        
        if #available(iOS 17, *) {
            
            self.traitChangeObserver = registerForTraitChanges(
                [UITraitUserInterfaceStyle.self],
                action: #selector(userInterfaceStyleDidChange)
            )

        }
        
    }
    
    private func destroy() {
        
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
    
}
