//
//  UIViewContainer.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public class UIViewContainer: UIView {

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard let view = super.hitTest(point, with: event), view != self else { return nil }
        return view
        
    }
    
}
