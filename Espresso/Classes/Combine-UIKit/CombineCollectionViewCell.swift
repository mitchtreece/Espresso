//
//  CombineCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 4/12/22.
//

import UIKit
import Combine

/// A Combine-based `UICollectionViewCell` subclass that provides common properties & functions when backed by a view model.
@available(iOS 13, *)
open class CombineCollectionViewCell<V: ViewModel>: UIViewModelCollectionViewCell<V> {
    
    /// The cell's model cancellable storage.
    public private(set) var modelCancellables = [AnyCancellable]()
    
    // The cell's component cancellable storage.
    public private(set) var componentCancellables = [AnyCancellable]()
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        bindComponents()
        
    }
    
    public override func setup(viewModel: V) -> Self {
        
        _ = super.setup(viewModel: viewModel)
        bindModel()
        return self
        
    }
    
    /// Binding function called in `setup(viewModel:)`. Override this to setup custom model bindings.
    ///
    /// The cell's `modelDisposeBag` is created when this is called.
    /// Subclasses that override this function should call `super.bindModel()` **before** accessing the `modelDisposeBag`.
    open func bindModel() {
        // Override me
    }
    
    /// Binding function called in `awakeFromNib()`. Override this to setup custom component bindings.
    ///
    /// The cell's `componentDisposeBag` is created when this is called.
    /// Subclasses that override this function should call `super.bindComponents()` **before** accessing the `componentDisposeBag`.
    open func bindComponents() {
        // Override me
    }
    
}
