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

class RxViewModel: UIViewModel {
    
    let title = "Rx / MVVM"
    let barButtonTitle = "Tap Me!"

    private(set) var labelText: RxReadOnlyVariable<String>!
    private var _labelText = RxVariable<String>(value: "RxViewModel says:\n0")

    override init() {
        self.labelText = RxReadOnlyVariable<String>(self._labelText)
    }
    
    func updateText() {
        
        let num = Int.random(in: 0...100)
        self._labelText.accept("RxViewModel says:\n\(num)")
        
    }
    
}
