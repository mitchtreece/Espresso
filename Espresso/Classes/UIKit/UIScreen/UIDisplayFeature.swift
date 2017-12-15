//
//  UIDisplayFeature.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public class UIDisplayFeature {
    
    public var frame: CGRect = CGRect.zero
    
    public var size: CGSize {
        return frame.size
    }
    
    public init(frame: CGRect) {
        self.frame = frame
    }
    
}

public class UINotch: UIDisplayFeature {
    
    public private(set) var cornerRadius: CGFloat = 20
    
}

public class UIHomeGrabber: UIDisplayFeature {
    //
}
