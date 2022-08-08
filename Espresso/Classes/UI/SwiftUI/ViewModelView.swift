//
//  ViewModelView.swift
//  Espresso
//
//  Created by Mitch Treece on 8/7/22.
//

import UIKit
import SwiftUI

public protocol ViewModelView: View {
    
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType { get }
    
    init(viewModel: ViewModelType)
    
}
