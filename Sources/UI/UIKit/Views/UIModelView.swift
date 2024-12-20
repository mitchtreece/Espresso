//
//  UIModelView.swift
//  Espresso
//
//  Created by Mitch Treece on 1/12/23.
//

#if canImport(UIKit)

import UIKit
import Espresso

/// An extended `UIViewEx` subclass that provides common
/// properties & functions when backed by a model.
open class UIModelView<M: ViewModel>: UIViewEx, ModelBinder {
    
    public typealias Model = M
    
    public private(set) var model: M!
    public private(set) var isModelBinded: Bool = false
    public var modelBag = CancellableBag()
    
    /// Initializes a view with a model.
    ///
    /// - parameter viewModel: The model.
    /// - parameter frame: The view's initial frame.
    public init(model: M,
                frame: CGRect = .zero) {
        
        super.init(frame: frame)
        setModel(model)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Configures the view with a model.
    ///
    /// - parameter model: The model.
    ///
    /// This setup function is useful when initilizing the view in a 2-step fashion.
    /// For example, when initializing a view from a nib, this can be called
    /// after the view is loaded to configure it with a model.
    @discardableResult
    public func setup(model: M) -> Self {
        
        setModel(model)
        return self
        
    }
    
    open override func willAppear() {
        
        super.willAppear()
        
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
        
        if let uiViewModel = model as? UIViewModel {
            uiViewModel.set(view: self)
        }
        
    }
    
}

#endif
