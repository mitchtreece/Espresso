//
//  Bindable.swift
//  Espresso
//
//  Created by Mitch on 12/19/24.
//

import Foundation

/// Protocol describing something that binds &
/// reacts to events.
public protocol Binder {
    
    /// Flag indicating if generic binding
    /// functions have been called yet.
    var isBinded: Bool { get }
    
    /// Generic cancellable bag.
    var bag: CancellableBag { get set }
    
    /// Generic binding function called once.
    /// Override this to setup custom bindings.
    ///
    /// This should empty the generic cancellable bag when called.
    /// Subclasses that override this function should call `super.bind()`
    /// **before** accessing the `bag`.
    func bind()
    
}

/// Protocol describing something that binds &
/// reacts to component events.
public protocol ComponentBinder {
    
    /// Flag indicating if component binding
    /// functions have been called yet.
    var isComponentBinded: Bool { get }
    
    /// Component cancellable bag.
    var componentBag: CancellableBag { get set }
    
    /// Component binding function called once.
    /// Override this to setup custom component bindings.
    ///
    /// This should empty the component cancellable bag when called.
    /// Subclasses that override this function should call `super.bindComponents()`
    /// **before** accessing the `componentBag`.
    func bindComponents()
    
}

/// Protocol describing something that binds &
/// reacts to model events.
public protocol ModelBinder {
    
    /// The associated model type.
    associatedtype Model: ViewModel
    
    /// Flag indicating if model binding
    /// functions have been called yet.
    var isModelBinded: Bool { get }
    
    var model: Model! { get }
    
    /// Model cancellable bag.
    var modelBag: CancellableBag { get set }
    
    /// Model function called once.
    /// Override this to setup custom model bindings.
    ///
    /// This should empty the model cancellable bag when called.
    /// Subclasses that override this function should call `super.bindModel()`
    /// **before** accessing the `modelBag`.
    func bindModel()
    
}
