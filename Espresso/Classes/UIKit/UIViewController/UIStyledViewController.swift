//
//  UIStyledViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

open class UIStyledViewController: UIViewController, UIStatusBarAppearanceProvider, UINavigationBarAppearanceProvider {
    
    // MARK: UIStatusBar
    
    open var preferredStatusBarAppearance: UIStatusBarAppearance? {
        return nil
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return preferredStatusBarAppearance?.style ?? UIStatusBarAppearance.default.style!
    }
    
    open override var prefersStatusBarHidden: Bool {
        return preferredStatusBarAppearance?.hidden ?? UIStatusBarAppearance.default.hidden!
    }
    
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return preferredStatusBarAppearance?.animation ?? UIStatusBarAppearance.default.animation!
    }
    
    open var preferredNavigationBarAppearance: UINavigationBarAppearance? {
        return nil
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = preferredNavigationBarAppearance?.title
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
}
