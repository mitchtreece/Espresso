//
//  UIViewControllerTransitionInteractor.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

internal class UIViewControllerTransitionInteractor: UIPercentDrivenInteractiveTransition {
    
    private var viewController: UIViewController
    private var navigationController: UINavigationController?
    private(set) var transitionInProgress = false
    
    internal init(viewController: UIViewController,
                  navigationController: UINavigationController?) {
        
        self.viewController = viewController
        self.navigationController = navigationController
        
        super.init()
        
        setup()
        
    }
    
    private func setup() {
        
        let edgePan = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(handleEdgePan(_:))
        )
        
        edgePan.edges = .left
        self.viewController.view.addGestureRecognizer(edgePan)
        
    }
    
    @objc private func handleEdgePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
        let view = recognizer.view!
        let translation = recognizer.translation(in: view)
        let progress = min(1, max(0, (translation.x / view.bounds.width)))
        
        switch recognizer.state {
        case .began:
            
            self.transitionInProgress = true
            
            if let nav = navigationController {
                nav.popViewController(animated: true)
            }
            else {
                
                self.viewController.dismiss(
                    animated: true,
                    completion: nil
                )
                
            }
            
        case .changed: update(progress)
        case .cancelled:
            
            self.transitionInProgress = false
            cancel()
            
        case .ended:
            
            self.transitionInProgress = false
            
            let velocity = recognizer.velocity(in: view)
            
            if (progress >= 0.5 || velocity.x > 0) {
                
                self.completionSpeed = 0.8
                finish()
                
            }
            else {
                cancel()
            }
            
        default: break
        }
        
    }
    
}
