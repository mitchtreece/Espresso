//
//  KeyboardViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 12/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class KeyboardViewController: UIStyledViewController {
    
    override var preferredStatusBarAppearance: UIStatusBarAppearance {
        
        // Being able to infer this from the current context would
        // be ideal instead of creating a new appearance object per vc
        
        return UIStatusBarAppearance()
        
    }
    
    override var preferredNavigationBarAppearance: UINavigationBarAppearance {
        
        // Being able to infer this from the current context would
        // be ideal instead of creating a new appearance object per vc
        
        let appearance = UINavigationBarAppearance()
        appearance.title = "Keyboard"
        appearance.barColor = UIColor.white
        appearance.titleColor = UIColor.black
        appearance.itemColor = UIColor.black
        
        if #available(iOS 11, *) {
            appearance.largeTitleDisplayMode = .always
            appearance.largeTitleColor = UIColor.black
        }
        
        return appearance
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
    }
    
}
