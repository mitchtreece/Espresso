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
    
    /// Binding function called in `setup(viewModel:)`.
    /// Override this to setup custom model bindings.
    open func bindModel() {
        // Override me
    }
    
    /// Binding function called in `awakeFromNib()`.
    /// Override this to setup custom component bindings.
    open func bindComponents() {
        // Override me
    }
    
}
