//
//  Coordinator+Debug.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

extension Coordinator /* Debug */ {
    
    internal func debugPrint(_ message: String) {
        
        guard self.appCoordinator.isDebugEnabled else { return }
        print("🎬 \(message)")
        
    }
    
}
