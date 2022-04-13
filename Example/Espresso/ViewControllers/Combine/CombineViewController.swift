//
//  CombineViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 4/12/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Espresso
import SnapKit

@available(iOS 13, *)
class CombineViewController: CombineViewModelViewController<CombineViewModel> {
    
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
            .asPublisher()
            .sink { print("☕️ RxViewController did appear") }
            .store(in: &self.modelCancellableBag)
        
        self.viewModel.$labelText
            .receive(on: DispatchQueue.main)
            .map { $0 as String? }
            .assign(to: \.text, on: self.label)
            .store(in: &self.modelCancellableBag)
        
    }
    
    override func bindComponents() {
        
        super.bindComponents()
        
        self.barItem.actionPublisher
            .sink { self.viewModel.updateText() }
            .store(in: &self.componentCancellableBag)
        
    }
    
}
