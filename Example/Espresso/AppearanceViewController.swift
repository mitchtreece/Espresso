//
//  AppearanceViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 4/26/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

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
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
