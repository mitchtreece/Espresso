//
//  TitleView.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 7/22/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    private let title: String
    private let bottomSpacing: CGFloat
    
    init(title: String,
         bottomSpacing: CGFloat = 0) {
        
        self.title = title
        self.bottomSpacing = bottomSpacing
        
    }
    
    var body: some View {
        
        VStack {
            
            Text(self.title)
                .font(.headline)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Spacer(minLength: 4)
            
            Divider()
            
            Spacer(minLength: self.bottomSpacing)
            
        }
        
    }
    
}
