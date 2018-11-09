//
//  UIViewModelCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/4/18.
//

import UIKit

open class UIViewModelCollectionViewCell<V: ViewModel>: UICollectionViewCell {
    
    public private(set) var viewModel: V!
    
    public func setup(viewModel: V) -> Self {
        
        guard self.viewModel !== viewModel else { return self }
        self.viewModel = viewModel
        return self
        
    }
    
}
