//
//  UIViewControllerEvents.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

public class UIViewControllerEvents {
    
    private class ProxyViewController: UIViewController {
        
        private let _viewDidLoad:               VoidEvent
        private let _viewWillAppear:            VoidEvent
        private let _viewDidAppear:             VoidEvent
        private let _viewWillDisappear:         VoidEvent
        private let _viewDidDisappear:          VoidEvent
        private let _didReceiveMemoryWarning:   VoidEvent
        
        init(viewDidLoad: VoidEvent,
             viewWillAppear: VoidEvent,
             viewDidAppear: VoidEvent,
             viewWillDisappear: VoidEvent,
             viewDidDisappear: VoidEvent,
             didReceiveMemoryWarning: VoidEvent) {
            
            self._viewDidLoad = viewDidLoad
            self._viewWillAppear = viewWillAppear
            self._viewDidAppear = viewDidAppear
            self._viewWillDisappear = viewWillDisappear
            self._viewDidDisappear = viewDidDisappear
            self._didReceiveMemoryWarning = didReceiveMemoryWarning
            
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
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            self._didReceiveMemoryWarning.dispatch()
        }
        
    }
    
    public let viewDidLoad          = VoidEvent()
    public let viewWillAppear       = VoidEvent()
    public let viewDidAppear        = VoidEvent()
    public let viewWillDisappear    = VoidEvent()
    public let viewDidDisappear     = VoidEvent()
    
    public let didReceiveMemoryWarning = VoidEvent()
        
    private let proxyViewController: ProxyViewController
    
    internal init(viewController: UIViewController) {
        
        self.proxyViewController = ProxyViewController(
            viewDidLoad: self.viewDidLoad,
            viewWillAppear: self.viewWillAppear,
            viewDidAppear: self.viewDidAppear,
            viewWillDisappear: self.viewWillDisappear,
            viewDidDisappear: self.viewDidDisappear,
            didReceiveMemoryWarning: self.didReceiveMemoryWarning
        )
        
        viewController.addChild(self.proxyViewController)
        viewController.view.addSubview(self.proxyViewController.view)
        
        self.proxyViewController.view.frame = .zero
        self.proxyViewController.view.autoresizingMask = []
        self.proxyViewController.didMove(toParent: viewController)
        
    }
    
}
