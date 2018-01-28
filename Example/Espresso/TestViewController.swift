//
//  TestViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 1/27/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class TestViewController: UIStyledViewController {
    
//    override var preferredStatusBarAppearance: UIStatusBarAppearance {
//
//        let appearance = UIStatusBarAppearance()
//        appearance.style = .default
//        return appearance
//
//    }
//
//    override var preferredNavigationBarAppearance: UINavigationBarAppearance {
//
//        let appearance = UINavigationBarAppearance.inferred(from: self)
//        appearance?.barColor = UIColor.green
//        return appearance ?? UINavigationBarAppearance()
//
//    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Test"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
    }
    
}
