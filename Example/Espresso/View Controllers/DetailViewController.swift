//
//  DetailViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 9/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

protocol DetailViewControllerDelegate: class {
    func detailViewControllerDidTapDone(_ viewController: DetailViewController)
}

class DetailViewController: UIViewController {
    
    var showsDismissButton: Bool = false
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if self.showsDismissButton {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(didTapDismiss(_:))
            )
            
        }
        
        if #available(iOS 13, *) {
            
            let contextView = ContextView(color: .groupTableViewBackground)
            self.view.addSubview(contextView)
            contextView.snp.makeConstraints { make in
                make.width.height.equalTo(150)
                make.center.equalToSuperview()
            }
            
        }
        
    }
    
    @objc private func didTapDismiss(_ sender: UIBarButtonItem) {
        self.delegate?.detailViewControllerDidTapDone(self)
    }
    
}
