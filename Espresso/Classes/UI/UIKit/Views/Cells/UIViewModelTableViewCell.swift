//
//  UIViewModelTableViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit

/// `UITableViewCell` subclass that provides common
/// properties & functions when backed by a view model.
open class UIViewModelTableViewCell<V: ViewModel>: UIBaseTableViewCell {
    
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
