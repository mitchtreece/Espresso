//
//  UIResponder+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

public extension UIResponder /* Parent ViewController */ {
    
    /// The responder's closest `UIViewController` ancestor.
    var parentViewController: UIViewController? {
        
        if let vc = self.next as? UIViewController {
            return vc
        }
        else if let _next = self.next {
            return _next.parentViewController
        }

        return nil

    }
    
}
