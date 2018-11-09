//
//  RxViewModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit
import RxSwift
import RxCocoa

open class RxViewModelViewController<V: ViewModel>: UIViewModelViewController<V> {
    
    public private(set) var modelDisposeBag: DisposeBag!
    public private(set) var componentDisposeBag: DisposeBag!
    
    private var isBinded: Bool = false
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if !self.isBinded {
            
            self.isBinded = true
            bindComponents()
            bindModel()
            
        }
        
    }
    
    open func bindComponents() {
        
        // Override me
        self.componentDisposeBag = DisposeBag()
        
    }
    
    open func bindModel() {
        
        // Override me
        self.modelDisposeBag = DisposeBag()
        
    }
    
}
