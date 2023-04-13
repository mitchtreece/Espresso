//
//  UIViewModelCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/4/18.
//

import UIKit

/// `UICollectionViewCell` subclass that provides
/// common properties & functions when backed by a view model.
open class UIViewModelCollectionViewCell<V: ViewModel>: UIBaseCollectionViewCell {
    
    /// The cell's backing view model.
    public private(set) var viewModel: V!
    
    /// Configures the cell with a view model.
    /// - Parameter viewModel: The view model.
    /// - Returns: This cell instance configured with a view model.
    @discardableResult
    public func setup(viewModel: V) -> Self {
        
        guard self.viewModel !== viewModel else { return self }
        self.viewModel = viewModel
        return self
        
    }
    
}
