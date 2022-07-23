//
//  Color.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

enum ESColor: CaseIterable {
    
    case red
    case green
    case blue
    
    var name: String {
        
        switch self {
        case .red: return "Red"
        case .green: return "Green"
        case .blue: return "Blue"
        }
        
    }
    
    var color: UIColor {
        
        switch self {
        case .red: return .red
        case .green: return .green
        case .blue: return .blue
        }
        
    }
    
}
