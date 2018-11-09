//
//  UIViewModelTableViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit

open class UIViewModelTableViewCell<V: ViewModel>: UITableViewCell {
    
    public private(set) var viewModel: V!
    
    public func setup(viewModel: V) -> Self {

        guard self.viewModel !== viewModel else { return self }
        self.viewModel = viewModel
        return self
        
    }
    
}
