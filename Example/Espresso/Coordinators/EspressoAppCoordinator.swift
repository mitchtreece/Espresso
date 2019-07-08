//
//  EspressoSceneCoordinator.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Director

class EspressoSceneCoordinator: SceneCoordinator {

    override func build() -> ViewCoordinator {
        return RootCoordinator()
    }
    
}
