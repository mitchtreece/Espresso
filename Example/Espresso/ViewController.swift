//
//  ViewController.swift
//  Espresso
//
//  Created by mitchtreece on 12/15/2017.
//  Copyright (c) 2017 mitchtreece. All rights reserved.
//

import UIKit
import Espresso
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        
        let type = UIDevice.current.type()
        let env = UIApplication.shared.environment
        print("\(type.displayName) (\(env.rawValue))")
        
        let v = UIView()
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            // make.left.right.smartEqualTo(20)
            make.left.right.smartEqualTo(20)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

