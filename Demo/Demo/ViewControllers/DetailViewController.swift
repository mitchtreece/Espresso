//
//  DetailViewController.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit
import EspressoUI

protocol DetailViewControllerDelegate: AnyObject {
    func detailViewControllerDidTapDone(_ viewController: DetailViewController)
}

class DetailViewController: UIBaseViewController {
    
    var showsDismissButton: Bool = false
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
                
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
        
    }
    
    @objc private func didTapDismiss(_ sender: UIBarButtonItem) {
        
        self.delegate?
            .detailViewControllerDidTapDone(self)
        
    }
    
}
