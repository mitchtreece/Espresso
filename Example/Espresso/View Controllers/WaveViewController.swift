//
//  WaveViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class WaveViewController: UIViewController {
    
    private var waveView: UIWaveView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "UIWaveView"
        
        self.waveView = UIWaveView()
        self.view.addSubview(self.waveView)
        self.waveView.snp.makeConstraints { make in
            make.leading.bottom.right.equalTo(0)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        self.waveView.waves = [
            .solid(height: 14, inset: 0, speed: 1, color: #colorLiteral(red: 0.9664415717, green: 0.8336953521, blue: 0.8843036294, alpha: 1)),
            .gradient(height: 14, inset: 4, speed: 2, colors: [
                #colorLiteral(red: 0.7941735387, green: 0.3622966409, blue: 0.626619041, alpha: 1),
                #colorLiteral(red: 0.9263296127, green: 0.3765163422, blue: 0.4450909495, alpha: 1).withAlphaComponent(0.7),
                #colorLiteral(red: 1, green: 0.6301068068, blue: 0.2299266458, alpha: 1).withAlphaComponent(0.6)
            ], stops: .equal)
        ]
        
    }
    
}
