//
//  UIStyledViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

open class UIStyledViewController: UIViewController, UIStatusBarAppearanceProvider, UINavigationBarAppearanceProvider {
    
    // MARK: UIStatusBarAppearance
    
    open var preferredStatusBarAppearance: UIStatusBarAppearance {
        
        // TODO: Grab appearance from current context by default
        
        return UIStatusBarAppearance.fromCurrentContext()
        
        // return UIStatusBarAppearance()
        
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
    
    // MARK: UINavigationBarAppearance
    
    open var preferredNavigationBarAppearance: UINavigationBarAppearance {
        
        // TODO: Grab appearance from current context by default

        return UINavigationBarAppearance()
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = preferredNavigationBarAppearance.title
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
}
