//
//  AnimationOperation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

internal class AnimationOperation: AsyncOperation {
    
    private var animation: Animation
    private var index: Int
    
    internal init(animation: Animation,
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
