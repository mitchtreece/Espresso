//
//  UIViewModelCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/4/18.
//

import UIKit

open class UIViewModelCollectionViewCell<T: ViewModel>: UICollectionViewCell {
    
    public private(set) var viewModel: T!
    
    public func setup(viewModel: T) -> Self {
        
        guard self.viewModel !== viewModel else { return self }
        self.viewModel = viewModel
        return self
        
    }
    
}
