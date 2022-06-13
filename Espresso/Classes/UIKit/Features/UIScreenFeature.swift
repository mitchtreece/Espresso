//
//  UIScreenFeature.swift
//  Espresso
//
//  Created by Mitch Treece on 6/12/22.
//

import UIKit

public class UIScreenFeature: UIDeviceFeature {
    
    public let frame: CGRect
    public let cornerRadius: CGFloat
    
    public init(name: String,
                description: String? = nil,
                frame: CGRect,
                cornerRadius: CGFloat,
                condition: @escaping Condition) {
        
        self.frame = frame
        self.cornerRadius = cornerRadius
        
        super.init(
            name: name,
            description: description,
            condition: condition
        )
        
    }
    
}

extension UIScreenFeature /* Features */ {
    
    static var notch: UIScreenFeature {
        
        let screen = UIScreen.main
        let device = UIDevice.current
        
        let size = CGSize(width: 209, height: 31)
        
        let origin = CGPoint(
            x: ((screen.bounds.width - size.width) / 2),
            y: 0
        )
                
        return .init(
            name: "Notch",
            description: "",
            frame: CGRect(
                origin: origin,
                size: size
            ),
            cornerRadius: 20,
            condition: { device.isModern }
        )
        
    }
    
    static var homeGrabber: UIScreenFeature {

        let screen = UIScreen.main
        let device = UIDevice.current
        
        let size = CGSize(
            width: screen.bounds.width,
            height: 23
        )
        
        let origin = CGPoint(
            x: 0,
            y: (screen.bounds.height - size.height)
        )
                
        return .init(
            name: "Home Grabber",
            description: "",
            frame: CGRect(
                origin: origin,
                size: size
            ),
            cornerRadius: 20,
            condition: { device.isModern }
        )
        
    }
    
}
