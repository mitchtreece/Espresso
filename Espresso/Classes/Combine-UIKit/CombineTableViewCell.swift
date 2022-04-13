//
//  CombineTableViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 4/12/22.
//

import UIKit
import Combine

/// A Combine-based `UITableViewCell` subclass that provides common properties & functions when backed by a view model.
@available(iOS 13, *)
open class CombineTableViewCell<V: ViewModel>: UIViewModelTableViewCell<V> {
    
    /// The cell's model cancellable bag.
    public var modelCancellableBag: CancellableBag!
    
    // The cell's component cancellable bag.
    public var componentCancellableBag: CancellableBag!
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        bindComponents()
        
    }
    
    public override func setup(viewModel: V) -> Self {
        
        _ = super.setup(viewModel: viewModel)
        bindModel()
        return self
        
    }
    
    /// Binding function called in `setup(viewModel:)`.
    /// Override this to setup custom model bindings.
    ///
    /// The cell's `modelCancellableBag` is created when this is called.
    /// Subclasses that override this function should call `super.bindModel()` **before** accessing the `modelCancellableBag`.
    open func bindModel() {
        self.modelCancellableBag = CancellableBag()
    }
    
    /// Binding function called in `awakeFromNib()`.
    /// Override this to setup custom component bindings.
    ///
    /// The cell's `componentCancellableBag` is created when this is called.
    /// Subclasses that override this function should call `super.bindComponents()` **before** accessing the `componentCancellableBag`.
    open func bindComponents() {
        self.componentCancellableBag = CancellableBag()
    }
    
}
