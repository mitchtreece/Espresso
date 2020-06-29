//
//  UIViewControllerEvents.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

/// `UIViewController` event holder class.
public class UIViewControllerEvents {
    
    private class ProxyViewController: UIViewController {
        
        private let _viewDidLoad: VoidEvent
        private let _viewWillAppear: VoidEvent
        private let _viewDidAppear: VoidEvent
        private let _viewWillDisappear: VoidEvent
        private let _viewDidDisappear: VoidEvent
        private let _didReceiveMemoryWarning: VoidEvent
        
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
            self._viewDidLoad.emit()
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            super.viewWillAppear(animated)
            self._viewWillAppear.emit()
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            
            super.viewDidAppear(animated)
            self._viewDidAppear.emit()
            
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            
            super.viewWillDisappear(animated)
            self._viewWillDisappear.emit()
            
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            
            super.viewDidDisappear(animated)
            self._viewDidDisappear.emit()
            
        }
        
        override func didReceiveMemoryWarning() {
            
            super.didReceiveMemoryWarning()
            self._didReceiveMemoryWarning.emit()
            
        }
        
    }
    
    /// Dispatched after the view controller's view loads.
    public let viewDidLoad = VoidEvent()
    
    /// Dispatched when the view controller's view will appear.
    public let viewWillAppear = VoidEvent()
    
    /// Dispatched after the view controller's view appears.
    public let viewDidAppear = VoidEvent()
    
    /// Dispatched when the view controller's view wil disappear.
    public let viewWillDisappear = VoidEvent()
    
    /// Dispatched after the view controller's view disappears.
    public let viewDidDisappear = VoidEvent()
    
    /// Dispatched after the view controller receives a memory warning.
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
