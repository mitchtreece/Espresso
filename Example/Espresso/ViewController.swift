//
//  ViewController.swift
//  Espresso
//
//  Created by mitchtreece on 12/15/2017.
//  Copyright (c) 2017 mitchtreece. All rights reserved.
//

import UIKit
import Espresso

class ViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        
        let type = UIDevice.current.type()
        let env = UIApplication.shared.environment
        print("\(type.displayName) (\(env.rawValue))")
        
        let v = UIView()
        
        let stack = Stack<UIView>()
        stack.push(v)
        stack.push(v)
        stack.push(v)
        stack.push(v)
        stack.pop()
        print(stack)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

