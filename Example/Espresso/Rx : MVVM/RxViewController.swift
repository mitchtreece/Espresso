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
        
        let waves = UIWaveView(waves: [
            .solid(height: 10, inset: 8, speed: 1, color: #colorLiteral(red: 0.9742994905, green: 0.8415424824, blue: 0.8921473622, alpha: 1)),
            .gradient(height: 25, speed: 2, colors: [#colorLiteral(red: 0.8025608063, green: 0.3659369349, blue: 0.6304686666, alpha: 1), #colorLiteral(red: 0.9994346499, green: 0.6217572093, blue: 0.2507359982, alpha: 1).withAlphaComponent(0.6)], stops: .equal)
        ])
        
        self.view.addSubview(waves)
        waves.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(300)
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
                print("☕️ RxViewController did appear")
            }
            .disposed(by: self.modelDisposeBag)
        
        self.viewModel.labelText.asObservable()
            .bind(to: self.label.rx.text)
            .disposed(by: self.modelDisposeBag)
        
    }
    
}
