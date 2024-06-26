//
//  UIBarButtonItem+Combine.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

#if canImport(UIKit)

import UIKit
import Combine
import Espresso

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

#endif
