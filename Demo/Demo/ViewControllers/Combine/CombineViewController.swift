//
//  CombineViewController.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit
import EspressoUI
import SnapKit

class CombineViewController: UICombineViewModelViewController<CombineViewModel> {
    
    private var barItem: UIBarButtonItem!
    private var label: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = self.viewModel.title
        
        setupSubviews()

    }
    
    private func setupSubviews() {
        
        self.view.backgroundColor = .systemGroupedBackground
                
        self.barItem = UIBarButtonItem()
        self.barItem.title = self.viewModel.barButtonTitle
        self.navigationItem.rightBarButtonItem = self.barItem
        
        self.label = UILabel()
        self.label.textAlignment = .center
        self.label.font = UIFont.boldSystemFont(ofSize: 20)
        self.label.numberOfLines = 0
        self.view.addSubview(self.label)
        self.label.snp.makeConstraints { (make) in
        
            make.left
                .greaterThanOrEqualTo(20)
            
            make.right
                .lessThanOrEqualTo(-20)
            
            make.center
                .equalToSuperview()
            
        }
        
    }
    
    func didTapButton() {
        
        self.viewModel
            .updateText()
        
        let numberString = self.viewModel
            .numberStringPublisher
            .value
        
        let number = self.viewModel
            .numberPublisher
            .value
        
        print("string: \"\(numberString ?? "nil")\"\nnumber: \(number ?? -1)")
        
    }
    
    override func bind() {
        
        super.bind()
        
        self.viewDidAppearPublisher
            .sink { animated in print("☕️ CombineViewController did appear, animated: \(animated)") }
            .store(in: &self.bag)
 
    }
    
    override func bindModel() {
        
        super.bindModel()

        self.viewModel.$text
            .receiveOnMain()
            .map { $0 as String? }
            .assign(to: \.text, on: self.label)
            .store(in: &self.modelBag)
        
    }
    
    override func bindComponents() {
        
        super.bindComponents()
        
        self.barItem.actionPublisher
            .sink { [weak self] in self?.didTapButton() }
            .store(in: &self.componentBag)
        
    }
    
}
