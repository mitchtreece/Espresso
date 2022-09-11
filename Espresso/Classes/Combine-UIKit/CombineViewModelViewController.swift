//
//  CombineViewModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 4/12/22.
//

import UIKit
import Combine

/// A Combine-based `UIViewController` subclass that provides common properties & functions when backed by a view model.
@available(iOS 13, *)
open class CombineViewModelViewController<V: ViewModel>: UIViewModelViewController<V> {
    
    /// A publisher that emits when the keyboard is about to be presented.
    public var keyboardWillShowPublisher: GuaranteePublisher<KeyboardAnimationInfo> {
        return self._keyboardWillShowPublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that emits when the keyboard finishes presenting.
    public var keyboardDidShowPublisher: GuaranteePublisher<KeyboardAnimationInfo> {
        return self._keyboardDidShowPublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that emits when the keyboard's frame is about to change.
    public var keyboardWillChangeFramePublisher: GuaranteePublisher<KeyboardAnimationInfo> {
        return self._keyboardWillChangeFramePublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that emits when the keyboard's frame finishes changing.
    public var keyboardDidChangeFramePublisher: GuaranteePublisher<KeyboardAnimationInfo> {
        return self._keyboardDidChangeFramePublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that emits when the keyboard is about to be dismissed.
    public var keyboardWillHidePublisher: GuaranteePublisher<KeyboardAnimationInfo> {
        return self._keyboardWillHidePublisher.eraseToAnyPublisher()
    }
    
    /// A publisher that emits when the keyboard finishes dismissing.
    public var keyboardDidHidePublisher: GuaranteePublisher<KeyboardAnimationInfo> {
        return self._keyboardDidHidePublisher.eraseToAnyPublisher()
    }
    
    /// The view controller's model cancellable bag.
    public var modelBag: CancellableBag!
    
    /// The view controller's component cancellable bag.
    public var componentBag: CancellableBag!
    
    /// The view controller's keyboard cancellable bag.
    private var keyboardBag: CancellableBag!
    
    /// Flag indicating if binding functions have been called yet.
    /// This is used to determine if the binding should should happen when `viewWillAppear(animated:)` is called.
    private(set) var isBinded: Bool = false
    
    private let _keyboardWillShowPublisher = GuaranteePassthroughSubject<KeyboardAnimationInfo>()
    private let _keyboardDidShowPublisher = GuaranteePassthroughSubject<KeyboardAnimationInfo>()
    private let _keyboardWillChangeFramePublisher = GuaranteePassthroughSubject<KeyboardAnimationInfo>()
    private let _keyboardDidChangeFramePublisher = GuaranteePassthroughSubject<KeyboardAnimationInfo>()
    private let _keyboardWillHidePublisher = GuaranteePassthroughSubject<KeyboardAnimationInfo>()
    private let _keyboardDidHidePublisher = GuaranteePassthroughSubject<KeyboardAnimationInfo>()
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if !self.isBinded {
                        
            bindModel()
            bindComponents()
            bindKeyboard()
            
            self.isBinded = true
            
        }
        
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`.
    /// Override this to setup custom component bindings.
    ///
    /// The view controller's model cancellable bag is created when this is called.
    /// Subclasses that override this function should call `super.bindModel()` **before** accessing the `modelBag`.
    open func bindModel() {
        self.modelBag = CancellableBag()
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`.
    /// Override this to setup custom component bindings.
    ///
    /// The view controller's component cancellable bag is created when this is called.
    /// Subclasses that override this function should call `super.bindComponents()` **before** accessing the `componentBag`.
    open func bindComponents() {
        self.componentBag = CancellableBag()
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`.
    /// Override this to setup custom keyboard bindings.
    ///
    /// The view controller's keyboard cancellable bag is created when this is called.
    /// Subclasses that override this function should call `super.bindKeyboard()` **before** accessing the `keyboardBag`.
    open func bindKeyboard() {
        
        self.keyboardBag = CancellableBag()
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { KeyboardAnimationInfo(notification: $0) }
            .sink { [unowned self] in self._keyboardWillShowPublisher.send($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardDidShowNotification)
            .compactMap { KeyboardAnimationInfo(notification: $0) }
            .sink { [unowned self] in self._keyboardDidShowPublisher.send($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { KeyboardAnimationInfo(notification: $0) }
            .sink { [unowned self] in self._keyboardWillChangeFramePublisher.send($0) }
            .store(in: &self.keyboardBag)
                
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardDidChangeFrameNotification)
            .compactMap { KeyboardAnimationInfo(notification: $0) }
            .sink { [unowned self] in self._keyboardDidChangeFramePublisher.send($0) }
            .store(in: &self.keyboardBag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .compactMap { KeyboardAnimationInfo(notification: $0) }
            .sink { [unowned self] in self._keyboardWillHidePublisher.send($0) }
            .store(in: &self.keyboardBag)
        
    }
    
}
