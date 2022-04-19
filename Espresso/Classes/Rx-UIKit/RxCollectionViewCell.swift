//
//  RxCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/4/18.
//

import UIKit
import RxSwift
import RxCocoa

/// An Rx-based `UICollectionViewCell` subclass that provides common properties & functions when backed by a view model.
open class RxCollectionViewCell<V: ViewModel>: UIViewModelCollectionViewCell<V> {
    
    /// The cell's model dispose bag.
    public private(set) var modelBag: DisposeBag!
    
    /// The cell's component dispose bag.
    public private(set) var componentBag: DisposeBag!
    
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
    /// The cell's model dispose bag is created when this is called.
    /// Subclasses that override this function should call `super.bindModel()` **before** accessing the `modelBag`.
    open func bindModel() {
        self.modelBag = DisposeBag()
    }
    
    /// Binding function called in `awakeFromNib()`.
    /// Override this to setup custom component bindings.
    ///
    /// The cell's component dispose bag is created when this is called.
    /// Subclasses that override this function should call `super.bindComponents()` **before** accessing the `componentBag`.
    open func bindComponents() {
        self.componentBag = DisposeBag()
    }
    
}
