//
//  UIViewModelView.swift
//  Espresso
//
//  Created by Mitch Treece on 1/12/23.
//

import UIKit

/// `UIView` subclass that provides common
/// properties & functions when backed by a view model.
open class UIViewModelView<V: ViewModel>: UIBaseView {
    
    /// The view's backing view model.
    public private(set) var viewModel: V!

    /// Initializes a view with a view model.
    /// - parameter viewModel: The view model.
    /// - parameter frame: The view's initial frame.
    public init(viewModel: V,
                frame: CGRect = .zero) {
        
        super.init(frame: frame)
        setViewModel(viewModel)
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Configures the view with a view model.
    /// - parameter viewModel: The view model.
    ///
    /// This setup function is useful when initilizing the view in a 2-step fashion.
    /// For example, when initializing a view from a nib, this can be called
    /// after the view is loaded to configure it with a view model.
    @discardableResult
    public func setup(viewModel: V) -> Self {
        
        setViewModel(viewModel)
        return self
        
    }
    
    // MARK: Private
    
    private func setViewModel(_ viewModel: V) {
        
        self.viewModel = viewModel
        
        if let uiViewModel = viewModel as? UIViewModel {
            uiViewModel.set(view: self)
        }
        
    }
    
}
