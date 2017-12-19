//
//  UIStyledViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

open class UIStyledViewController: UIViewController, UIStatusBarAppearanceProvider, UINavigationBarAppearanceProvider {
    
    // MARK: UIStatusBarAppearanceProvider
    
    open var preferredStatusBarAppearance: UIStatusBarAppearance {
        return UIStatusBarAppearance(style: .default, hidden: false, animation: .fade)
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
    
    // MARK: UINavigationBarAppearanceProvider
    
    open var preferredNavigationBarColor: UIColor {
        return UIColor.white
    }
    
    open var preferredNavigationBarItemColor: UIColor {
        return UIColor.black
    }
    
    open var preferredNavigationBarTitle: String? {
        return nil
    }
    
    open var preferredNavigationBarTitleFont: UIFont {
        return UIFont.preferredFont(forTextStyle: .headline)
    }
    
    open var preferredNavigationBarTitleColor: UIColor {
        return UIColor.black
    }
    
    open var prefersNavigationBarHidden: Bool {
        return false
    }
    
    open var prefersNavigationBarTransparent: Bool {
        return false
    }
    
    open var preferredNavigationBarBackButtonImage: UIImage? {
        return nil
    }
    
    open var preferredNavigationBarBackButtonTitle: String? {
        return nil
    }
    
    @available(iOS 11, *)
    open var preferredNavigationBarLargeTitleFont: UIFont {
        return UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    @available(iOS 11, *)
    open var preferredNavigationBarLargeTitleColor: UIColor {
        return preferredNavigationBarTitleColor
    }
    
    // MARK: Common
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = preferredNavigationBarTitle
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
}
