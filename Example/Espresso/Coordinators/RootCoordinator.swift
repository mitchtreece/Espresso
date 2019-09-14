//
//  RootCoordinator.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Director
import Espresso

class RootCoordinator: ViewCoordinator {

    override func build() -> UIViewController {
        return RootViewController(delegate: self)
    }
    
}

extension RootCoordinator: RootViewControllerDelegate {
    
    func rootViewController(_ vc: RootViewController, didSelectTransitionRow row: RootViewController.TransitionRow) {
        
        let vc = DetailViewController()
        vc.title = row.title
        vc.showsDismissButton = true
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.transition = row.transition
        modal(nav)
        
    }
    
    func rootViewControllerWantsToPresentRxViewController(_ vc: RootViewController) {
        
        let vc = RxViewController(viewModel: RxViewModel())
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
}

extension RootCoordinator: DetailViewControllerDelegate {
    
    func detailViewControllerDidTapDone(_ viewController: DetailViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
