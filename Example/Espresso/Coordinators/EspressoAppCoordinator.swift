//
//  EspressoAppCoordinator.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

class EspressoAppCordinator: AppCoordinator {
    
    override func load() -> Coordinator {
        return RootCoordinator(in: self)
    }
    
}
