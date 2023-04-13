//
//  UIZeroSizeView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit

public class UIZeroSizeView: UIBaseView {
    
    public override var intrinsicContentSize: CGSize {
        return .zero
    }
    
}
