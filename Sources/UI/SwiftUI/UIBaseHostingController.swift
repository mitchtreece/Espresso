//
//  UIBaseHostingController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/24.
//

import UIKit
import SwiftUI

public protocol UIBaseHostingControllerConfigurable {
    
    var prefersNavigationBarHidden: Bool { get set }
    var isSwipeBackGestureEnabled: Bool { get set }
    
}

public struct UIBaseHostingControllerConfiguration: UIBaseHostingControllerConfigurable {
    
    public var prefersNavigationBarHidden: Bool = true
    public var isSwipeBackGestureEnabled: Bool = true
    
}

public typealias UIBaseHostingControllerBuilder = (inout UIBaseHostingControllerConfiguration)->()

open class UIBaseHostingController<Content: View>: UIHostingController<Content>,
                                                   UIUserInterfaceStyleAdaptable {

    public var viewDidLoadPublisher: GuaranteePublisher<Void> {
        self._viewDidLoad.eraseToAnyPublisher()
    }
    
    public var viewWillAppearPublisher: GuaranteePublisher<Bool> {
        self._viewWillAppear.eraseToAnyPublisher()
    }
    
    public var viewIsAppearingPublisher: GuaranteePublisher<Bool> {
        self._viewIsAppearing.eraseToAnyPublisher()
    }
    
    public var viewWillLayoutSubviewsPublisher: GuaranteePublisher<Void> {
        self._viewWillLayoutSubviews.eraseToAnyPublisher()
    }
    
    public var viewDidLayoutSubviewsPublisher: GuaranteePublisher<Void> {
        self._viewDidLayoutSubviews.eraseToAnyPublisher()
    }
    
    public var viewDidLoadGeometryPublisher: GuaranteePublisher<Void> {
        self._viewDidLoadGeometry.eraseToAnyPublisher()
    }
    
    public var viewDidUpdateGeometryPublisher: GuaranteePublisher<Bool> {
        self._viewDidUpdateGeomtery.eraseToAnyPublisher()
    }
    
    public var viewDidAppearPublisher: GuaranteePublisher<Bool> {
        return self._viewDidAppear.eraseToAnyPublisher()
    }
    
    public var viewWillDisappearPublisher: GuaranteePublisher<Bool> {
        self._viewWillDisappear.eraseToAnyPublisher()
    }
    
    public var viewDidDisappearPublisher: GuaranteePublisher<Bool> {
        self._viewDidDisappear.eraseToAnyPublisher()
    }
    
    public var didRecieveMemoryWarningPublisher: GuaranteePublisher<Void> {
        self._didReceiveMemoryWarning.eraseToAnyPublisher()
    }
    
    public var baseNavigationController: UIBaseNavigationController? {
        return self.navigationController as? UIBaseNavigationController
    }
 
    public var prefersNavigationBarHidden: Bool = true {
        didSet {
            self.navigationController?.setNavigationBarHidden(
                prefersNavigationBarHidden,
                animated: false
            )
        }
    }
    
    public var isSwipeBackGestureEnabled: Bool = true {
        didSet {
            self.baseNavigationController?.isSwipeBackGestureEnabled = self.isSwipeBackGestureEnabled
        }
    }
    
    public var modalStyle: UIModalStyle {
        get {
            return .init(modalPresentationStyle: self.modalPresentationStyle)
        }
        set {
            
            self.modalPresentationStyle = newValue
                .asModalPresentationStyle()
            
        }
    }
    
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
    
    @available(iOS 13, *)
    public var isInteractiveModalDismissEnabled: Bool {
        get { return !self.isModalInPresentation }
        set { self.isModalInPresentation = !newValue }
    }
    
    public var safeAreaWindowInsets: UIEdgeInsets {
            
        let window =  self.view.window ?? UIApplication.shared.keySceneWindow
        
        return window?
            .safeAreaInsets ?? self.view.safeAreaInsets
        
    }
    
    private(set) var isFirstAppearance: Bool = true
    private(set) var isKeyboardVisible: Bool = false
    
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
    
    public init(rootView: Content,
                builder: UIBaseHostingControllerBuilder?) {
        
        var config = UIBaseHostingControllerConfiguration()
        builder?(&config)
        
        self.prefersNavigationBarHidden = config.prefersNavigationBarHidden
        self.isSwipeBackGestureEnabled = config.isSwipeBackGestureEnabled
        
        super.init(rootView: rootView)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    open func viewDidLoadGeometry() {
        
        self._viewDidLoadGeometry
            .send()
        
    }

    open func viewDidUpdateGeomtery(_ animated: Bool) {
        
        self._viewDidUpdateGeomtery
            .send(animated)
        
    }
    
    open override func viewDidAppear(_ animated: Bool) {
                   
        super.viewDidAppear(animated)
       
        self.isFirstAppearance = false
        
        self.baseNavigationController?
            .isSwipeBackGestureEnabled = self.isSwipeBackGestureEnabled
        
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
        
        guard #available(iOS 17, *) else {
            return
        }
        
        self.traitChangeObserver = registerForTraitChanges(
            [UITraitUserInterfaceStyle.self],
            action: #selector(userInterfaceStyleDidChange)
        )
        
    }
    
    private func destroy() {
            
        unbindKeyboardEvents()
        
        if #available(iOS 17, *) {
            
            if let observer = self.traitChangeObserver as? UITraitChangeRegistration {
                unregisterForTraitChanges(observer)
            }
            
        }
        
    }
    
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
