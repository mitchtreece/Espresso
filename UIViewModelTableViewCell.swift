//
//  UIViewModelTableViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit

public class UIViewModelTableViewCell<T: ViewModel>: UITableViewCell {
    
    public private(set) var viewModel: T!
    
    public func setup(viewModel: T) -> Self {
        
        guard self.viewModel !== viewModel else { return self }
        self.viewModel = viewModel
        return self
        
    }
    
}
