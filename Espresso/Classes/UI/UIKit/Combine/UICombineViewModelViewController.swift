//
//  UICombineViewModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 4/12/22.
//

import UIKit
import Combine

/// A Combine-based `UIViewController` subclass that provides
/// common properties & functions when backed by a view model.
open class UICombineViewModelViewController<V: ViewModel>: UIViewModelViewController<V> {
    
    /// The view controller's generic cancellable bag.
    public var bag = CancellableBag()
    
    /// The view controller's model cancellable bag.
    public var modelBag = CancellableBag()
    
    /// The view controller's component cancellable bag.
    public var componentBag = CancellableBag()

    /// Flag indicating if binding functions have been called yet.
    /// This is used to determine if the binding should should happen when `viewWillAppear(animated:)` is called.
    private(set) var isBinded: Bool = false

    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if !self.isBinded {
                   
            bind()
            bindModel()
            bindComponents()
            
            self.isBinded = true
            
        }
        
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`.
    /// Override this to setup custom bindings.
    ///
    /// The view controller's cancellable bag is emptied when this is called.
    /// Subclasses that override this function should call `super.bind()` **before** accessing the `bag`.
    open func bind() {
        self.bag.removeAll()
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`.
    /// Override this to setup custom component bindings.
    ///
    /// The view controller's model cancellable bag is emptied when this is called.
    /// Subclasses that override this function should call `super.bindModel()` **before** accessing the `modelBag`.
    open func bindModel() {
        self.modelBag.removeAll()
    }
    
    /// Binding function called once in `viewWillAppear(animated:)`.
    /// Override this to setup custom component bindings.
    ///
    /// The view controller's component cancellable bag is emptied when this is called.
    /// Subclasses that override this function should call `super.bindComponents()` **before** accessing the `componentBag`.
    open func bindComponents() {
        self.componentBag.removeAll()
    }
    
}
