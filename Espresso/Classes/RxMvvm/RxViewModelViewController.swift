//
//  RxViewModelViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import UIKit
import RxSwift
import RxCocoa

public class RxViewModelViewController<T: ViewModel>: UIViewModelViewController<T> {
    
    public private(set) var modelDisposeBag: DisposeBag!
    public private(set) var componentDisposeBag: DisposeBag!
    
    private var isBinded: Bool = false
    
    public override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if !self.isBinded {
            
            self.isBinded = true
            bindComponents()
            bindModel()
            
        }
        
    }
    
    public func bindComponents() {
        
        // Override me
        self.componentDisposeBag = DisposeBag()
        
    }
    
    public func bindModel() {
        
        // Override me
        self.modelDisposeBag = DisposeBag()
        
    }
    
}
