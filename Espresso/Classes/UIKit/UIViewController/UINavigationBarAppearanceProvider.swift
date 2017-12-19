//
//  UINavigationBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public protocol UINavigationBarAppearanceProvider {
    
    // Bar style
    
    var preferredNavigationBarColor: UIColor { get }
    var preferredNavigationBarItemColor: UIColor { get }
    var preferredNavigationBarTitle: String? { get }
    var preferredNavigationBarTitleFont: UIFont { get }
    var preferredNavigationBarTitleColor: UIColor { get }
    var prefersNavigationBarHidden: Bool { get }
    var prefersNavigationBarTransparent: Bool { get }
    
    // Large bar style
    
    @available(iOS 11, *) var preferredNavigationBarLargeTitleFont: UIFont { get }
    @available(iOS 11, *) var preferredNavigationBarLargeTitleColor: UIColor { get }
    
    // Back button style
    
    var preferredNavigationBarBackButtonImage: UIImage? { get }
    var preferredNavigationBarBackButtonTitle: String? { get }
    
}

public extension UINavigationBarAppearanceProvider {
    
    var childViewControllerForNavigationBarAppearanceProviding: UIViewController? {
        return nil
    }
    
}
