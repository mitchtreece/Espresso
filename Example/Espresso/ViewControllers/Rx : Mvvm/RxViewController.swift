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
        
        self.barItem = UIBarButtonItem()
        self.barItem.title = self.viewModel.barButtonTitle
        self.navigationItem.rightBarButtonItem = self.barItem
        
        self.label = UILabel()
        self.label.backgroundColor = .clear
        self.label.textAlignment = .center
        self.label.font = UIFont.boldSystemFont(ofSize: 20)
        self.label.numberOfLines = 0
        self.view.addSubview(self.label)
        self.label.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }

    }
    
    override func bindModel() {
        
        super.bindModel()
        
        self.events.viewDidAppear
            .asObservable()
            .bind { _ in print("☕️ RxViewController did appear") }
            .disposed(by: self.modelBag)
        
        self.viewModel.labelText.asObservable()
            .bind(to: self.label.rx.text)
            .disposed(by: self.modelBag)
        
    }
    
    override func bindComponents() {
        
        super.bindComponents()
        
        self.barItem.rx.tap
            .bind { self.viewModel.updateText() }
            .disposed(by: self.componentBag)
        
    }
    
}
