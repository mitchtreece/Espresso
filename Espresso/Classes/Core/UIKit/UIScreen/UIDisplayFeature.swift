//
//  UIDisplayFeature.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

/**
 Class describing the physical characteristics of a display feature.
 */
public class UIDisplayFeature {
    
    /**
     The display feature's frame.
     */
    public private(set) var frame: CGRect = .zero
    
    /**
     The display feature's frame size.
     */
    public var size: CGSize {
        return self.frame.size
    }
    
    internal init(frame: CGRect) {
        self.frame = frame
    }
    
}
