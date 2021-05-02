//
//  UIContainerView.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

/// `UIView` subclass that delegates it's touch events to other receivers.
open class UIContainerView: UIView {

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard let view = super.hitTest(point, with: event), view != self else { return nil }
        return view
        
    }
    
}
