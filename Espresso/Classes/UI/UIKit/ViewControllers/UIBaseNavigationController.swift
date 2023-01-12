//
//  UIBaseNavigationController.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

/// `UINavigationController` subclass that provides
/// common helper functions & properties.
open class UIBaseNavigationController: UINavigationController,
                                       UIUserInterfaceStyleAdaptable {
    
    /// A publisher that sends when the view finishes loading.
    public var viewDidLoadPublisher: GuaranteePublisher<Void> {
        return self._viewDidLoad.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view is about to appear.
    public var viewWillAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewWillAppear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view finishes appearing.
    public var viewDidAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewDidAppear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view is about to disappear.
    public var viewWillDisappearPublisher: GuaranteePublisher<Bool> {
        return self._viewWillDisappear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view finishes disappearing.
    public var viewDidDisappearPublisher: GuaranteePublisher<Bool> {
        return self._viewDidDisappear.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the view receives a memory warning.
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
    private var _viewWillAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidAppear = GuaranteePassthroughSubject<Bool>()
    private var _viewWillDisappear = GuaranteePassthroughSubject<Bool>()
    private var _viewDidDisappear = GuaranteePassthroughSubject<Bool>()
    private var _didReceiveMemoryWarning = TriggerPublisher()
    
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
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.swipeBackDelegate.originalGestureDelegate = self.interactivePopGestureRecognizer?.delegate
        self.swipeBackDelegate.navigationController = self
        self.interactivePopGestureRecognizer?.delegate = self.swipeBackDelegate
        
        self._viewDidLoad.send()
        
    }

    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
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
                
        self._viewDidDisappear.send(animated)
        
    }
    
    open override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        self._didReceiveMemoryWarning.send()
        
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
