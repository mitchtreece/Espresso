//
//  CombineViewModel.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 4/12/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Espresso

class CombineViewModel: UIViewModel {
    
    let title = "Combine"
    let barButtonTitle = "Tap Me!"

    @Published private(set) var labelText: String = "CombineViewModel says:\n0"
    
    func updateText() {

        let num = Int.random(in: 0...100)
        self.labelText = "CombineViewModel says:\n\(num)"

    }
    
}
