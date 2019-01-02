//
//  RxTableViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit
import RxSwift
import RxCocoa

/**
 An Rx-based `UITableViewCell` subclass that provides common properties & functions when backed by a view model.
 */
open class RxTableViewCell<V: ViewModel>: UIViewModelTableViewCell<V> {
    
    /// The cell's model dispose bag.
    public private(set) var modelDisposeBag: DisposeBag!
    
    // The cell's component dispose bag.
    public private(set) var componentDisposeBag: DisposeBag!
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        bindComponents()
        
    }
    
    public override func setup(viewModel: V) -> Self {
        
        _ = super.setup(viewModel: viewModel)
        bindModel()
        return self
        
    }
    
    /**
     Binding function called in `awakeFromNib()`. Override this to setup custom component bindings.
     
     The cell's `componentDisposeBag` is created when this is called.
     Subclasses that override this function should call `super.bindComponents()` **before** accessing the `componentDisposeBag`.
     */
    open func bindComponents() {
        
        // Override me
        self.componentDisposeBag = DisposeBag()
        
    }
    
    /**
     Binding function called in `setup(viewModel:)`. Override this to setup custom model bindings.
     
     The cell's `modelDisposeBag` is created when this is called.
     Subclasses that override this function should call `super.bindModel()` **before** accessing the `modelDisposeBag`.
     */
    open func bindModel() {
        
        // Override me
        self.modelDisposeBag = DisposeBag()
        
    }
    
}
