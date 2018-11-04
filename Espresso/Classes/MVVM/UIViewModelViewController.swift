//
//  UIViewModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit

open class UIViewModelViewController<T: ViewModel>: UIViewController {
    
    public private(set) var viewModel: T!
    
    public init(viewModel: T) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setup(viewModel: T) {
        self.viewModel = viewModel
    }
    
}
