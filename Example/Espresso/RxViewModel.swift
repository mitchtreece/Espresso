//
//  RxViewModel.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 11/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Espresso
import RxSwift
import RxCocoa

class RxViewModel: ViewModel {
    
    private(set) var title = "Rx / MVVM"
    private(set) var barButtonTitle = "Tap Me!"
    
    private(set) var labelText = BehaviorRelay<String>(value: "RxViewModel says:\n0")
    
    func updateText() {
        
        let num = Int.random(in: 0...100)
        self.labelText.accept("RxViewModel says:\n\(num)")
        
    }
    
}
