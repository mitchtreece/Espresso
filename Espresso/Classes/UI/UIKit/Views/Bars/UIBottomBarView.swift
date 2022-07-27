//
//  UIBottomBarView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Foundation

open class UIBottomBarView: UIBarView {
    
    open override func setupView() {
        
        super.setupView()
        
        self.anchor = .bottom
        self.divider = .none
        self.dividerAnchor = .top
        
    }

}
