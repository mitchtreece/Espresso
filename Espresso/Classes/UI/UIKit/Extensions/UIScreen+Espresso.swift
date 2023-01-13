//
//  UIScreen+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public extension UIScreen /* Size */ {
    
    /// The screen bound's size.
    var size: CGSize {
        return self.bounds.size
    }

    /// The screen's orientation independent (portrait) size.
    var naturalSize: CGSize {
        
        let width = min(
            self.size.width,
            self.size.height
        )
        
        let height = max(
            self.size.width,
            self.size.height
        )
        
        return CGSize(
            width: width,
            height: height
        )
        
    }
    
}

public extension UIScreen /* Features */ {
    
    private static let cornerRadiusKey: String = {
                
        return ["Radius", "Corner", "display", "_"]
            .reversed()
            .joined()
        
    }()
    
    /// The screen's corner radius.
    var cornerRadius: CGFloat {
        
        guard AppleDevice
            .current
            .isModern else { return 0 }
        
        return (value(forKey: Self.cornerRadiusKey) as? CGFloat) ?? 0
                
    }
    
}
