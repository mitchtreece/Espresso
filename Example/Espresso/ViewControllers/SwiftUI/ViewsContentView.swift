//
//  ViewsRootView.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 7/22/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import Espresso

struct ViewsContentView: View {
                
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .fill(Color(UIColor.systemBackground))
            
            ScrollView {
                
                HStack {
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        
                        TitleView(
                            title: "BlurView",
                            bottomSpacing: 8
                        )
                        
                        BlurView()
                            .frame(height: 100)
                        
                        Spacer()
                        
                        TitleView(
                            title: "GradientView",
                            bottomSpacing: 8
                        )
                        
                        GradientView()
                            .frame(height: 100)
                        
                    }
                    
                    Spacer()
                    
                }
                
            }
            
        }
        
    }
    
}
