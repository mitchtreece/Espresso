//
//  UIBaseNavigationController.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

/// `UINavigationController` subclass that provides common helper functions & properties.
open class UIBaseNavigationController: UINavigationController, UserInterfaceStyleAdaptable {
    
    /// A publisher that sends when the view finishes loading.
    public var viewDidLoadPublisher: GuaranteePublisher<Void> {
        return self._viewDidLoadPublisher.asPublisher()
    }
    
    /// A publisher that sends when the view is about to appear.
    public var viewWillAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewWillAppearPublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view finishes appearing.
    public var viewDidAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewDidAppearPublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view is about to disappear.
    public var viewWillDisappearPublisher: GuaranteePublisher<Bool> {
        return self._viewWillDisappearPublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view finishes disappearing.
    public var viewDidDisappearPublisher: GuaranteePublisher<Bool> {
        return self._viewDidDisappearPublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view receives a memory warning.
    public var didRecieveMemoryWarningPublisher: GuaranteePublisher<Void> {
        return self._didReceiveMemoryWarningPublisher.asPublisher()
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
            self.interactivePopDelegate.isSwipeBackGestureEnabled = isInteractiveDismissEnabled
        }
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
    
    /// Flag indicating if the view controller has a modal-sheet presentation style.
    public var isInModalSheetPresentation: Bool {
        return self.modalStyle.isModalSheet
    }
    
    /// Flag indicating if the view controller enforces modal-behavior,
    /// or supports interactive dismissal.
    @available(iOS 13, *)
    public var isInteractiveDismissEnabled: Bool {
        get { return !self.isModalInPresentation }
        set { self.isModalInPresentation = !newValue }
    }
    
    private var _viewDidLoadPublisher = TriggerPublisher()
    private var _viewWillAppearPublisher = GuaranteePassthroughSubject<Bool>()
    private var _viewDidAppearPublisher = GuaranteePassthroughSubject<Bool>()
    private var _viewWillDisappearPublisher = GuaranteePassthroughSubject<Bool>()
    private var _viewDidDisappearPublisher = GuaranteePassthroughSubject<Bool>()
    private var _didReceiveMemoryWarningPublisher = TriggerPublisher()
    
    private let interactivePopDelegate = HiddenNavBarInteractivePopDelegate()
    
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
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.interactivePopDelegate.originalGestureDelegate = self.interactivePopGestureRecognizer?.delegate
        self.interactivePopDelegate.navigationController = self
        self.interactivePopGestureRecognizer?.delegate = self.interactivePopDelegate
        
        self._viewDidLoadPublisher.fire()
        
    }

    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self._viewWillAppearPublisher.send(animated)
                
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.isFirstAppearance = false
        
        self._viewDidAppearPublisher.send(animated)
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self._viewWillDisappearPublisher.send(animated)
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
                
        self._viewDidDisappearPublisher.send(animated)
        
    }
    
    open override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        self._didReceiveMemoryWarningPublisher.fire()
        
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
