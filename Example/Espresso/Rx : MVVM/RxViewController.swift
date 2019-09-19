//
//  RxViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 11/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Espresso
import SnapKit

class RxViewController: RxViewModelViewController<RxViewModel> {
    
    private var barItem: UIBarButtonItem!
    private var label: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = self.viewModel.title
        self.view.backgroundColor = UIColor.white
        
        barItem = UIBarButtonItem()
        barItem.title = self.viewModel.barButtonTitle
        self.navigationItem.rightBarButtonItem = barItem
        
        label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    override func bindComponents() {
        
        super.bindComponents()
        
        barItem.rx.tap
            .bind { self.viewModel.updateText() }
            .disposed(by: self.componentDisposeBag)
        
    }
    
    override func bindModel() {
        
        super.bindModel()
        
        self.events.viewDidAppear.observable
            .bind { _ in
                print("Did appear!")
            }
            .disposed(by: self.modelDisposeBag)
        
        self.viewModel.labelText.asObservable()
            .bind(to: self.label.rx.text)
            .disposed(by: self.modelDisposeBag)
        
    }
    
}
