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

    /// The screen's orientation independent (potrait-locked) size.
    var lockedSize: CGSize {
        
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
    
    /// The screen's feature insets.
    ///
    /// This takes into account things like: status-bars, notches, home-grabbers, etc.
    var featureInsets: UIEdgeInsets {
        
        let statusBar = UIApplication.shared
            .statusBarFrame
            .height
        
        guard UIDevice.current.isModern else {
            
            return UIEdgeInsets(
                top: statusBar,
                left: 0,
                bottom: 0,
                right: 0
            )
            
        }
        
        let bottom = self.homeGrabber?.size.height ?? 0
        
        return UIEdgeInsets(
            top: statusBar,
            left: 0,
            bottom: bottom,
            right: 0
        )
        
    }

    /// The screen's corner radius.
    var cornerRadius: CGFloat {
        
        guard UIDevice.current.isModern else { return 0 }
        
        if UIDevice.current.isModern {
            
            // NOTE: I'm not sure if iPhone & iPad have the same corner radii.
            // I should double check this.
            
            return 44
            
        }
        
        return 0
        
    }
    
    /// The screen's top notch.
    var topNotch: UINotch? {
        
        guard UIDevice.current.isModernPhone else { return nil }
        return UINotch(screen: self)
        
    }
    
    /// The screen's bottom home-grabber.
    var homeGrabber: UIHomeGrabber? {
        
        guard UIDevice.current.isModern else { return nil }
        return UIHomeGrabber(screen: self)
        
    }
    
}
