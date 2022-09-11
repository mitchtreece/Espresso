//
//  OrientationObservingViewController.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit
import Combine

@available(iOS 13, *)
internal class OrientationObservingViewController: UIViewController {
    
    typealias ViewTransitionParameters = (size: CGSize, transitionCoordinator: UIViewControllerTransitionCoordinator)
    
    static let shared = OrientationObservingViewController()
    
    private let _viewTransitionPublisher = GuaranteePassthroughSubject<ViewTransitionParameters>()
    var viewTransitionPublisher: GuaranteePublisher<ViewTransitionParameters> {
        return self._viewTransitionPublisher.eraseToAnyPublisher()
    }
    
    init() {
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        UIApplication.shared
            .activeWindow?
            .rootViewController?
            .addChild(self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(
            to: size,
            with: coordinator
        )
        
        self._viewTransitionPublisher.send((
            size: size,
            transitionCoordinator: coordinator
        ))
        
    }
    
}
