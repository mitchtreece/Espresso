//
//  UINotch.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import UIKit

/// Object describing the characteristics of a screen notch.
public class UINotch: UIScreenFeature {
    
    /// The notch's corner radius.
    public var cornerRadius: CGFloat {
        return 20 // Is this the same for all devices?
    }

    public override var frame: CGRect {
        
        // Is this the same for all devices?
        
        let size = CGSize(
            width: 209,
            height: 31
        )
        
        let origin = CGPoint(
            x: ((self.screen.bounds.width - size.width) / 2),
            y: 0
        )
        
        return CGRect(
            origin: origin,
            size: size
        )
        
    }
    
}
