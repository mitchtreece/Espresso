//
//  UITopBarView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit

open class UITopBarView: UIBarView {
    
    open override func setupView() {
        
        super.setupView()
        
        self.anchor = .top
        self.divider = .none
        self.dividerAnchor = .bottom
        
    }
    
}
