//
//  UIBarButtonItem+Combine.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import UIKit
import Combine

public extension UIBarButtonItem {
    
    /// A publisher that emits when the `UIBarButtonItem` action is invoked.
    var actionPublisher: GuaranteePublisher<Void> {
        
        return Publishers.TargetAction(
            control: self,
            addTargetAction: { c, t, a in
                
                c.target = t
                c.action = a
                
            },
            removeTargetAction: { c, _, _ in
                
                c?.target = nil
                c?.action = nil
                
            })
            .eraseToAnyPublisher()
        
    }
    
}
