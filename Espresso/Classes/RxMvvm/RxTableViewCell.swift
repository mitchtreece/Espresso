//
//  RxTableViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit
import RxSwift
import RxCocoa

open class RxTableViewCell<T: RxCellViewModel>: UIViewModelTableViewCell<T> {
    
    public private(set) var modelDisposeBag: DisposeBag!
    public private(set) var componentDisposeBag: DisposeBag!
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        bindComponents()
        
    }
    
    public override func setup(viewModel: T) -> Self {
        
        _ = super.setup(viewModel: viewModel)
        bindModel()
        return self
        
    }
    
    open func bindComponents() {
        
        // Override me
        self.componentDisposeBag = DisposeBag()
        
    }
    
    open func bindModel() {
        
        // Override me
        self.modelDisposeBag = DisposeBag()
        
    }
    
}
