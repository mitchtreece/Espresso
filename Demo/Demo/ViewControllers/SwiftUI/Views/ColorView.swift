//
//  ColorView.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
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
