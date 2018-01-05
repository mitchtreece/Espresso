//
//  UINavigationBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public class UINavigationBarAppearance {
    
    public var barColor: UIColor = UIColor.white
    public var itemColor: UIColor = UIColor.black
    public var title: String?
    public var titleFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
    public var titleColor: UIColor = UIColor.black
    public var hidden: Bool = false
    public var transparent: Bool = false
    
    // @available(iOS 11, *) ///////////
    public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode!
    public var largeTitleFont: UIFont!
    public var largeTitleColor: UIColor = UIColor.black
    ////////////////////////////////////
    
    public var backButtonHidden: Bool = false
    public var backButtonImage: UIImage?
    public var backButtonTitle: String?
    
    public init() {
        
        if #available(iOS 11, *) {
            largeTitleDisplayMode = .never
            largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        }
        
    }
    
    public convenience init(barColor: UIColor,
                            itemColor: UIColor,
                            title: String?,
                            titleFont: UIFont,
                            titleColor: UIColor,
                            hidden: Bool,
                            transparent: Bool) {
        
        self.init()
        self.barColor = barColor
        self.itemColor = itemColor
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.hidden = hidden
        self.transparent = transparent
        
    }
    
}

public protocol UINavigationBarAppearanceProvider {
    var preferredNavigationBarAppearance: UINavigationBarAppearance { get }
}
