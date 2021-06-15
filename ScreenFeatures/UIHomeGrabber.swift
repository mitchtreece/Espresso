//
//  UIHomeGrabber.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import UIKit

/// Object describing the characteristics of a screen home-grabber.
public class UIHomeGrabber: UIScreenFeature {
    
    public override var frame: CGRect {
        
        let size = CGSize(
            width: self.screen.bounds.width,
            height: 23
        )
        
        let origin = CGPoint(
            x: 0,
            y: (self.screen.bounds.height - size.height)
        )
        
        return CGRect(
            origin: origin,
            size: size
        )
        
    }
    
}
