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
    
    // The view controller's model cancellable bag.
    public var modelBag: CancellableBag!
    
    // The view controller's component cancellable bag.
    public var componentBag: CancellableBag!

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
    
}
