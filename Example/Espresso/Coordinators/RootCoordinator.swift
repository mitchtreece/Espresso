//
//  RootCoordinator.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

class RootCoordinator: Coordinator {
    
    override func load() -> UIViewController {
        return RootViewController(delegate: self)
    }
    
}

extension RootCoordinator: RootViewControllerDelegate {
    
    func rootViewController(_ vc: RootViewController, didSelectAppearanceRow row: RootViewController.AppearanceRow) {
        
        let vc = AppearanceViewController()
        vc.title = row.title
        vc.delegate = self
        
        switch row {
        case .default:
            
            vc.statusBarAppearance = UIStatusBarAppearance()
            vc.navBarAppearance = UINavigationBarAppearance()
            self.navigationController.pushViewController(vc, animated: true)
        
        case .inferred:
            
            vc.statusBarAppearance = UIStatusBarAppearance.inferred(for: vc)
            vc.navBarAppearance = UINavigationBarAppearance.inferred(for: vc)
            self.navigationController.pushViewController(vc, animated: true)
        
        case .custom:
            
            let status = UIStatusBarAppearance()
            status.style = .lightContent

            let nav = UINavigationBarAppearance()
            nav.barColor = UIColor(white: 0.1, alpha: 1)
            nav.titleColor = UIColor.white
            nav.itemColor = UIColor.white

            if #available(iOS 11, *) {
                nav.largeTitleDisplayMode = .always
                nav.largeTitleColor = UIColor.white
                nav.largeTitleFont = UIFont.systemFont(ofSize: 40, weight: .black)
            }

            vc.statusBarAppearance = status
            vc.navBarAppearance = nav

            self.navigationController.pushViewController(vc, animated: true)
        
        case .modal:
            
            let navBar = UINavigationBarAppearance()
            navBar.titleColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
            navBar.titleFont = UIFont.systemFont(ofSize: 16, weight: .black)
            navBar.itemColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
            navBar.transparent = true

            vc.showsDismissButton = true
            vc.statusBarAppearance = UIStatusBarAppearance()
            vc.navBarAppearance = navBar

            let nav = UIStyledNavigationController(rootViewController: vc)
            self.presentModal(viewController: nav)
            
        }
        
    }
    
    func rootViewController(_ vc: RootViewController, didSelectTransitionRow row: RootViewController.TransitionRow) {
        
        let vc = AppearanceViewController()
        vc.title = row.title
        vc.showsDismissButton = true
        vc.delegate = self
        
        let navBar = UINavigationBarAppearance()
        navBar.titleColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
        navBar.titleFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        navBar.itemColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
        navBar.transparent = true
        vc.navBarAppearance = navBar
        
        let nav = UIStyledNavigationController(rootViewController: vc)
        nav.transition = row.transition
        
        self.presentModal(viewController: nav)
        
    }
    
    func rootViewControllerWantsToPresentRxViewController(_ vc: RootViewController) {
        
        let vc = RxViewController(viewModel: RxViewModel())
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func rootViewControllerWantsToPresentRxExampleViewController(_ vc: RootViewController) {
        
        let viewModel = RxExampleViewModel()

        let tableVC = RxExampleTableViewController(viewModel: viewModel)
        let tableNav = UINavigationController(rootViewController: tableVC)

        let collectionVC = RxExampleCollectionViewController(viewModel: viewModel)
        let collectionNav = UINavigationController(rootViewController: collectionVC)

        let tabController = UITabBarController()
        tabController.viewControllers = [tableNav, collectionNav]

        let transition = UICoverTransition()
        transition.coveredViewParallaxAmount = 100

        tabController.transition = transition
        self.presentModal(viewController: tabController)
        
    }
    
}

extension RootCoordinator: AppearanceViewControllerDelegate {
    
    func appearanceViewControllerDidTapDone(_ vc: AppearanceViewController) {
        vc.dismiss(animated: true, completion: nil)
    }
    
}
