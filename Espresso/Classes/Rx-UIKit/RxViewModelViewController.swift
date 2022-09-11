//
//  RxViewModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit
import RxSwift
import RxCocoa

/// An Rx-based `UIViewController` subclass that provides common properties & functions when backed by a view model.
open class RxViewModelViewController<V: ViewModel>: UIViewModelViewController<V> {
    
    /// The view controller's model dispose bag.
    public private(set) var modelBag: DisposeBag!
    
    /// The view controller's component dispose bag.
    public private(set) var componentBag: DisposeBag!

    /// Flag indicating if binding functions have been called yet.
    /// This is used to determine if the binding should should happen when `viewWillAppear(animated:)` is called.
    private var isBinded: Bool = false
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if !self.isBinded {
            
            bindModel()
            bindComponents()
            
            self.isBinded = true
            
        }
        
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`. Override this to setup custom component bindings.
    ///
    /// The view controller's model dispose bag is created when this is called.
    /// Subclasses that override this function should call `super.bindModel()` **before** accessing the `modelBag`.
    open func bindModel() {
        self.modelBag = DisposeBag()
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`. Override this to setup custom component bindings.
    ///
    /// The view controller's component dispose bag is created when this is called.
    /// Subclasses that override this function should call `super.bindComponents()` **before** accessing the `componentBag`.
    open func bindComponents() {
        self.componentBag = DisposeBag()
    }
    
}
