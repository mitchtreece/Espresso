//
//  UIModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

#if canImport(UIKit)

import UIKit
import Espresso

/// An extended `UIViewControllerEx` subclass that provides common
/// properties & functions when backed by a model.
open class UIModelViewController<M: ViewModel>: UIViewControllerEx, ModelBinder {
    
    public typealias Model = M
    
    public private(set) var model: M!
    public private(set) var isModelBinded: Bool = false
    public var modelBag = CancellableBag()
    
    /// Initializes a view controller with a model.
    ///
    /// - parameter model: The model.
    /// - parameter nibName: The nib name.
    /// - parameter bundle: The bundle to load from.
    public init(model: M,
                nibName: String? = nil,
                bundle: Bundle? = nil) {
        
        super.init(
            nibName: nibName,
            bundle: bundle
        )
        
        setModel(model)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Configures the view controller with a model.
    /// - parameter model: The model.
    ///
    /// This setup function is useful when initilizing the view controller in a 2-step fashion.
    /// For example, when initializing a view controller from a storyboard, this can be called
    /// after the view controller is loaded to configure the view with a model.
    @discardableResult
    public func setup(model: M) -> Self {
        
        setModel(model)
        return self
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if !self.isModelBinded {
            
            bindModel()
            self.isModelBinded = true
            
        }
        
    }
    
    open func bindModel() {
        self.modelBag.removeAll()
    }
    
    // MARK: Private
    
    private func setModel(_ model: M) {
        
        self.model = model
        
        if let uiViewControllerModel = model as? UIViewControllerModel {
            uiViewControllerModel.set(viewController: self)
        }
        else if let uiViewModel = model as? UIViewModel {
            uiViewModel.set(view: self.view)
        }
        
    }

}

#endif
