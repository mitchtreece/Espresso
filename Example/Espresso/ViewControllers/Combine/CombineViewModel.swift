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

    @Published private(set) var text: String = "CombineViewModel says:\n0"
    
    private var numberString = GuaranteeValueSubject<String?>(nil)
    var numberStringPublisher: GuaranteePublisher<String?> {
        return self.numberString.eraseToAnyPublisher()
    }
    
    var numberPublisher: GuaranteePublisher<Double?> {
        
        return self.numberStringPublisher
            .map { $0 != nil ? Double($0!) : nil }
            .eraseToAnyPublisher()
        
    }
    
    func updateText() {

        let number = Int.random(in: 0...100)
        self.text = "CombineViewModel says:\n\(number)"
        self.numberString.value = String(number)

    }
    
}
