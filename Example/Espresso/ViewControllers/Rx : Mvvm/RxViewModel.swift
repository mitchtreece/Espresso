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

    private var _labelText = BehaviorRelay<String>(value: "RxViewModel says:\n0")
    var labelText: Observable<String> {
        return self._labelText.asObservable()
    }

    func updateText() {
        
        let num = Int.random(in: 0...100)
        self._labelText.accept("RxViewModel says:\n\(num)")
        
    }
    
}
