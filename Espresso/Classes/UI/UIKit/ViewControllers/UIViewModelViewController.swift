//
//  UIViewModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit

/// `UIViewController` subclass that provides common
/// properties & functions when backed by a view model.
open class UIViewModelViewController<V: ViewModel>: UIBaseViewController {
    
    /// The view controller's backing view model.
    public private(set) var viewModel: V!
    
    /// Initializes a view controller with a view model.
    /// - parameter viewModel: The view model.
    /// - parameter nibName: The nib name.
    /// - parameter bundle: The bundle to load from.
    public init(viewModel: V,
                nibName: String? = nil,
                bundle: Bundle? = nil) {
        
        super.init(
            nibName: nibName,
            bundle: bundle
        )
                
        setViewModel(viewModel)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Configures the view controller with a view model.
    /// - parameter viewModel: The view model.
    ///
    /// This setup function is useful when initilizing the view controller in a 2-step fashion.
    /// For example, when initializing a view controller from a storyboard, this can be called
    /// after the view controller is loaded to configure the view with a view model.
    @discardableResult
    public func setup(viewModel: V) -> Self {
        
        setViewModel(viewModel)
        return self
        
    }
    
    // MARK: Private
    
    private func setViewModel(_ viewModel: V) {
        
        self.viewModel = viewModel
        
        if let uiViewControllerModel = viewModel as? UIViewControllerModel {
            uiViewControllerModel.set(viewController: self)
        }
        else if let uiViewModel = viewModel as? UIViewModel {
            uiViewModel.set(view: self.view)
        }
        
    }
    
}
