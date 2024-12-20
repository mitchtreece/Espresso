//
//  UIModelCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/4/18.
//

#if canImport(UIKit)

import UIKit
import Espresso

/// An extended `UICollectionViewCellEx` subclass that provides
/// common properties & functions when backed by a model.
open class UIModelCollectionViewCell<M: ViewModel>: UICollectionViewCellEx, ModelBinder {
    
    public typealias Model = M
    
    public private(set) var model: M!
    public private(set) var isModelBinded: Bool = false
    public var modelBag = CancellableBag()
    
    /// Configures the cell with a model.
    ///
    /// - parameter model: The model.
    /// - returns: This cell instance configured with a model.
    @discardableResult
    public func setup(model: M) -> Self {

        guard self.model !== model else {
            return self
        }
        
        self.model = model
        
        return self
        
    }
    
    public func bindModel() {
        self.modelBag.removeAll()
    }
    
}

#endif
