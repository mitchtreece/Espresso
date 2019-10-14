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
        nav.transition = row.transition
        modal(nav)
        
    }
    
    func rootViewController(_ vc: RootViewController, didSelectViewRow row: RootViewController.ViewRow) {
              
        var vc: UIViewController!
        
        switch row {
        case .wave: vc = WaveViewController()
        }
        
        push(vc)
        
    }
    
    func rootViewController(_ vc: RootViewController, didSelectMenuRow row: RootViewController.MenuRow) {
        
        if #available(iOS 13, *) {
            
            var vc: UIViewController
            
            switch row {
            case .view:
                
                vc = ContextMenuViewController()
                vc.title = row.title
                
            case .table:
                
                let contextTableVC = ContextMenuTableViewController()
                contextTableVC.title = row.title
                contextTableVC.delegate = self
                vc = contextTableVC
                
            case .collection:
                
                let contextCollectionVC = ContextMenuCollectionViewController()
                contextCollectionVC.title = row.title
                contextCollectionVC.delegate = self
                vc = contextCollectionVC
                
            }
            
            push(vc)
            
        }
        
    }
    
    func rootViewControllerWantsToPresentRxViewController(_ vc: RootViewController) {
        
        let vc = RxViewController(viewModel: RxViewModel())
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
}

@available(iOS 13, *)
extension RootCoordinator: ContextMenuTableViewControllerDelegate {
    
    func contextMenuTableViewController(_ vc: ContextMenuTableViewController, didSelectColor color: Color) {
        
        let vc = DetailViewController()
        vc.view.backgroundColor = color.color
        push(vc)
        
    }
    
}

@available(iOS 13, *)
extension RootCoordinator: ContextMenuCollectionViewControllerDelegate {
    
    func contextMenuCollectionViewController(_ vc: ContextMenuCollectionViewController, didSelectColor color: Color) {
        
        let vc = DetailViewController()
        vc.view.backgroundColor = color.color
        push(vc)
        
    }
    
}

extension RootCoordinator: DetailViewControllerDelegate {
    
    func detailViewControllerDidTapDone(_ viewController: DetailViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
