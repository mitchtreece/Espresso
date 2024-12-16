//
//  UITouchForwardingView.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/24.
//

import UIKit

/// `UIView` subclass that forwards touches to another receiver.
open class UITouchForwardingView: UIView {
    
    /// The view to forward touches to.
    public weak var touchReceiver: UIView?
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard let view = super.hitTest(point, with: event) else {
            return nil
        }

        guard view === self, let point = self.touchReceiver?.convert(point, from: self) else {
            return view
        }

        return self.touchReceiver?.hitTest(
            point,
            with: event
        )
        
    }
    
}
