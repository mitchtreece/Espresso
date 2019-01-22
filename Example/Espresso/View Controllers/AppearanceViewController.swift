//
//  AppearanceViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 4/26/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

protocol AppearanceViewControllerDelegate: class {
    func appearanceViewControllerDidTapDone(_ vc: AppearanceViewController)
}

class AppearanceViewController: UIStyledViewController {
    
    override var preferredStatusBarAppearance: UIStatusBarAppearance {
        return statusBarAppearance ?? UIStatusBarAppearance()
    }

    override var preferredNavigationBarAppearance: UINavigationBarAppearance {
        return navBarAppearance ?? UINavigationBarAppearance()
    }
    
    var statusBarAppearance: UIStatusBarAppearance?
    var navBarAppearance: UINavigationBarAppearance?
    var showsDismissButton: Bool = false
    
    weak var delegate: AppearanceViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if showsDismissButton {
            let dismissItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDismiss(_:)))
            self.navigationItem.rightBarButtonItem = dismissItem
        }
        
    }
    
    @objc private func didTapDismiss(_ sender: UIBarButtonItem) {
        self.delegate?.appearanceViewControllerDidTapDone(self)
    }
    
}
