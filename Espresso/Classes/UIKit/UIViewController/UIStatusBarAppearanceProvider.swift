//
//  UIStatusBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public class UIStatusBarAppearance {
    
    public var style: UIStatusBarStyle = .default
    public var hidden: Bool = false
    public var animation: UIStatusBarAnimation = .fade
    
    public init() {
        //
    }
    
    public convenience init(style: UIStatusBarStyle, hidden: Bool, animation: UIStatusBarAnimation) {
        
        self.init()
        self.style = style
        self.hidden = hidden
        self.animation = animation
        
    }
    
}

public protocol UIStatusBarAppearanceProvider {
    var preferredStatusBarAppearance: UIStatusBarAppearance { get }
}
