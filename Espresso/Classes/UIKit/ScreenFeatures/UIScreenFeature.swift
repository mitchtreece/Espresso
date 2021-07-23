//
//  UIScreenFeature.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

/// Object describing the characteristics of a screen feature.
public class UIScreenFeature {
    
    internal let screen: UIScreen
    
    /// The screen feature's frame.
    public var frame: CGRect {
        return .zero
    }
    
    /// The screen feature's size.
    public var size: CGSize {
        return self.frame.size
    }
    
    internal init(screen: UIScreen) {
        self.screen = screen
    }
     
}
