//
//  UITouchForwardingViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/24.
//

import UIKit

/// `UIViewController` subclass that forwards touches to another receiver.
open class UITouchForwardingViewController: UIViewController {
    
    /// The view to forward touches to.
    public var touchReceiver: UIView? {
        get { return self.viewAsTouchForwarding.touchReceiver }
        set { self.viewAsTouchForwarding.touchReceiver = newValue }
    }
    
    private var viewAsTouchForwarding: UITouchForwardingView {
        return self.view as! UITouchForwardingView
    }
    
    open override func loadView() {
        self.view = UITouchForwardingView()
    }
    
}
