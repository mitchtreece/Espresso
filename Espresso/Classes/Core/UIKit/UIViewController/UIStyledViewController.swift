//
//  UIStyledViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

/**
 A `UIViewController` subclass that implements common appearance properties.
 */
open class UIStyledViewController: UIViewController, UIStatusBarAppearanceProvider, UINavigationBarAppearanceProvider {
    
    open var preferredStatusBarAppearance: UIStatusBarAppearance {
        return UIStatusBarAppearance.inferred(for: self) ?? UIStatusBarAppearance()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return preferredStatusBarAppearance.style
    }
    
    open override var prefersStatusBarHidden: Bool {
        return preferredStatusBarAppearance.hidden
    }
    
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return preferredStatusBarAppearance.animation
    }
    
    /**
     The view controller's preferred navigation bar appearance.
     */
    open var preferredNavigationBarAppearance: UINavigationBarAppearance {
        return UINavigationBarAppearance.inferred(for: self) ?? UINavigationBarAppearance()
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
}
