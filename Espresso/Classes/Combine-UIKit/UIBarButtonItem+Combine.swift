//
//  UIBarButtonItem+Combine.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import UIKit
import Combine

@available(iOS 13, *)
public extension UIBarButtonItem {
    
    var actionPublisher: AnyPublisher<Void, Never> {
        
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
