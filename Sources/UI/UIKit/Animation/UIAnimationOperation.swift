//
//  UIAnimationOperation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

// Ignore this import warning
//
// We need to import this so SPM modules
// have access to 'Core' classes
import Espresso
////////////////////////////////////////

internal class UIAnimationOperation: AsyncOperation {
    
    private var animation: UIAnimation
    private var index: Int
    
    internal init(animation: UIAnimation,
                  index: Int) {
        
        self.animation = animation
        self.index = index
        
    }
    
    override func main() {
        
        super.main()
        
        DispatchQueue.main.async {
            
            self.animation.start(completion: {
                self.state = .finished
            })
            
        }
        
    }
    
}
