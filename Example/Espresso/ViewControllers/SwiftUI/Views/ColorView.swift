//
//  ColorView.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/17/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct ColorView: View {
    
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
        
        self.color
        
    }
    
}
