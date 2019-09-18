//
//  UIViewControllerLife.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

public class UIViewControllerLife {
    
    private class ProxyViewController: UIViewController {
        
        private let _viewDidLoad:        ObservableVoidEvent
        private let _viewWillAppear:     ObservableVoidEvent
        private let _viewDidAppear:      ObservableVoidEvent
        private let _viewWillDisappear:  ObservableVoidEvent
        private let _viewDidDisappear:   ObservableVoidEvent
        
        init(viewDidLoad: ObservableVoidEvent,
             viewWillAppear: ObservableVoidEvent,
             viewDidAppear: ObservableVoidEvent,
             viewWillDisappear: ObservableVoidEvent,
             viewDidDisappear: ObservableVoidEvent) {
            
            self._viewDidLoad = viewDidLoad
            self._viewWillAppear = viewWillAppear
            self._viewDidAppear = viewDidAppear
            self._viewWillDisappear = viewWillDisappear
            self._viewDidDisappear = viewDidDisappear
            
            super.init(
                nibName: nil,
                bundle: nil
            )
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self._viewDidLoad.dispatch()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self._viewWillAppear.dispatch()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            self._viewDidAppear.dispatch()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self._viewWillDisappear.dispatch()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            self._viewDidDisappear.dispatch()
        }
        
    }
    
    public let viewDidLoad          = ObservableVoidEvent()
    public let viewWillAppear       = ObservableVoidEvent()
    public let viewDidAppear        = ObservableVoidEvent()
    public let viewWillDisappear    = ObservableVoidEvent()
    public let viewDidDisappear     = ObservableVoidEvent()
        
    private let proxyViewController: ProxyViewController
    
    internal init(viewController: UIViewController) {
        
        self.proxyViewController = ProxyViewController(
            viewDidLoad: self.viewDidLoad,
            viewWillAppear: self.viewWillAppear,
            viewDidAppear: self.viewDidAppear,
            viewWillDisappear: self.viewWillDisappear,
            viewDidDisappear: self.viewDidDisappear
        )
        
        viewController.addChild(self.proxyViewController)
        viewController.view.addSubview(self.proxyViewController.view)
        
        self.proxyViewController.view.frame = .zero
        self.proxyViewController.view.autoresizingMask = []
        self.proxyViewController.didMove(toParent: viewController)
        
    }
    
}
