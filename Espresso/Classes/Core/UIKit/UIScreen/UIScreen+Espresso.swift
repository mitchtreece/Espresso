//
//  UIScreen+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public extension UIScreen /* Size */ {
    
    /**
     The screen's bounds size.
     */
    public var size: CGSize {
        return bounds.size
    }
    
    /**
     The screen's orientation independent (potrait-locked) size.
     */
    public var sizeOrientationIndependent: CGSize {
        
        let width = min(self.size.width, self.size.height)
        let height = max(self.size.width, self.size.height)
        return CGSize(width: width, height: height)
        
    }
    
}

public extension UIScreen /* Display Features */ {
    
    /**
     The screen's display feature insets. These take into account features like: status-bars, notches, home-grabbers, etc.
     */
    public var displayFeatureInsets: UIEdgeInsets {
        
        let statusBar = UIApplication.shared.statusBarFrame.height
        
        guard UIDevice.current.isPhoneX else {
            return UIEdgeInsets(top: statusBar, left: 0, bottom: 0, right: 0)
        }
        
        let bottom = UIScreen.main.homeGrabber?.size.height ?? 0
        return UIEdgeInsets(top: statusBar, left: 0, bottom: bottom, right: 0)
        
    }
    
    /**
     The screen's corner radius.
     */
    public var cornerRadius: CGFloat {
        
        guard UIDevice.current.isPhoneX else { return 0 }
        return 44
        
    }
    
    /**
     The screen's top notch.
     */
    public var topNotch: UINotch? {
        
        guard UIDevice.current.isPhoneX else { return nil }
        let size = CGSize(width: 209, height: 31)
        let frame = CGRect(x: ((UIScreen.main.bounds.width - size.width) / 2), y: 0, width: size.width, height: size.height)
        let notch = UINotch(frame: frame)
        return notch
        
    }
    
    /**
     The screen's bottom home-grabber.
     */
    public var homeGrabber: UIHomeGrabber? {
        
        guard UIDevice.current.isPhoneX else { return nil }
        let size = CGSize(width: UIScreen.main.bounds.width, height: 23)
        let frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - size.height), width: size.width, height: size.height)
        let grabber = UIHomeGrabber(frame: frame)
        return grabber
        
    }
    
}
