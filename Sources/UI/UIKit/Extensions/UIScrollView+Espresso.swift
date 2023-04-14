//
//  UIScrollView+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

import UIKit

public extension UIScrollView {
    
    /// Scrolls the view to the bottom of it's content.
    /// - parameter animated: Flag indicating if the scroll should be performed with an animation; _defaults to `true`_.
    func scrollToBottom(animated: Bool = true) {
        
        let rect = CGRect(
            x: 0,
            y: (self.contentSize.height - 1),
            width: self.bounds.width,
            height: 1
        )
        
        scrollRectToVisible(
            rect,
            animated: animated
        )
        
    }
    
}
