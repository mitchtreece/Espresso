//
//  UIViewEx.swift
//  Espresso
//
//  Created by Mitch Treece on 9/16/19.
//

#if canImport(UIKit)

import UIKit

/// An extended `UIView` subclass that provides
/// common helper functions & properties.
open class UIViewEx: UIView, UIViewCommon, UIViewLifecycle, UIViewAppearance {
    
    public var onWillAppear: GuaranteePublisher<Void> {
        return self._willAppear.asAny()
    }
    
    public var onDidAppear: GuaranteePublisher<Void> {
        return self._didAppear.asAny()
    }
    
    public private(set) var isBinded: Bool = false
    public private(set) var isComponentBinded: Bool = false

    public var bag = CancellableBag()
    public var componentBag = CancellableBag()
    
    private var _willAppear = TriggerPublisher()
    private var _didAppear = TriggerPublisher()
    
    private var traitObserver: AnyObject?
    
    // MARK: Functions
    
    deinit {
        destroy()
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
        willAppear()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setup()
        willAppear()
        
    }
    
    open func willAppear() {
        
        if !self.isBinded {
                   
            bind()
            self.isBinded = true
            
        }
        
        if !self.isComponentBinded {
            
            bindComponents()
            self.isComponentBinded = true
            
        }
        
        self._willAppear.send()
        
        DispatchQueue.main.async { [weak self] in
            self?.didAppear()
        }
        
    }
    
    open func didAppear() {
        self._didAppear.send()
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
    
    @available(iOS, deprecated: 17, message: "Use `registerForTraitChanges(traits:handler:)` instead")
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)
        
        if #unavailable(iOS 17) {
            
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                userInterfaceStyleDidChange()
            }
            
        }
        
    }
    
    // MARK: Private
    
    private func setup() {
        
        if #available(iOS 17, *) {
            
            self.traitObserver = registerForTraitChanges(
                [UITraitUserInterfaceStyle.self],
                action: #selector(userInterfaceStyleDidChange)
            )

        }
        
    }
    
    private func destroy() {
        
        if #available(iOS 17, *) {
            
            if let observer = self.traitObserver as? UITraitChangeRegistration {
                unregisterForTraitChanges(observer)
            }
            
        }
        
    }
    
}

#endif
