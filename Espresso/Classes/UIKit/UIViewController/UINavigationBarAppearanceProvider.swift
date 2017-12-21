//
//  UINavigationBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public struct UINavigationBarAppearance {
    
    public var color: UIColor?
    public var itemColor: UIColor?
    public var title: String?
    public var titleFont: UIFont?
    public var titleColor: UIColor?
    public var hidden: Bool?
    public var transparent: Bool?
    
    // @available(iOS 11, *) ///////////
    public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode?
    public var largeTitleFont: UIFont?
    public var largeTitleColor: UIColor?
    ////////////////////////////////////
    
    public var backButtonHidden: Bool?
    public var backButtonImage: UIImage?
    public var backButtonTitle: String?
    
    public init() {
        //
    }
    
    public init(color: UIColor?,
                itemColor: UIColor?,
                title: String?,
                titleFont: UIFont?,
                titleColor: UIColor?,
                hidden: Bool,
                transparent: Bool) {
        
        self.init()
        self.color = color
        self.itemColor = itemColor
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.hidden = hidden
        self.transparent = transparent
        
    }
    
    public static var `default`: UINavigationBarAppearance {
        
        var appearance = UINavigationBarAppearance()
        
        appearance.color = UIColor.white
        appearance.itemColor = UIColor.black
        appearance.title = nil
        appearance.titleFont = UIFont.preferredFont(forTextStyle: .headline)
        appearance.titleColor = UIColor.black
        appearance.hidden = false
        appearance.transparent = false
        
        if #available(iOS 11, *) {
            appearance.largeTitleDisplayMode = .automatic
            appearance.largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
            appearance.largeTitleColor = appearance.titleColor
        }
        
        appearance.backButtonHidden = false
        appearance.backButtonImage = nil
        appearance.backButtonTitle = nil
        
        return appearance
        
    }
    
}

public protocol UINavigationBarAppearanceProvider {
    var preferredNavigationBarAppearance: UINavigationBarAppearance? { get }
}
