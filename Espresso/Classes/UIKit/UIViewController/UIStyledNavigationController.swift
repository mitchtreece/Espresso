//
//  UIStyledNavigationController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public class UIStyledNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    private var statusBarStyle: UIStatusBarStyle = .default
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    public override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
        self.delegate = self

    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.delegate = self
        
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Style initial view controller
        
        if let vc = viewControllers.first, vc is UINavigationBarAppearanceProvider, viewControllers.count > 0 {
            update(with: vc, sourceVC: nil, animated: false)
        }
        
    }
    
    private func update(with vc: UIViewController, sourceVC: UIViewController?, animated: Bool) {
        
        let _vc = vc
        
        if let provider = _vc as? UIStatusBarAppearanceProvider {
            statusBarStyle = provider.preferredStatusBarAppearance.style
            setNeedsStatusBarAppearanceUpdate()
        }
        
        guard let provider = _vc as? UINavigationBarAppearanceProvider else { return }
        
        navigationBar.barTintColor = provider.preferredNavigationBarColor
        navigationBar.tintColor = provider.preferredNavigationBarItemColor
        navigationBar.titleTextAttributes = [
            .font: provider.preferredNavigationBarTitleFont,
            .foregroundColor: provider.preferredNavigationBarTitleColor
        ]
        
        if #available(iOS 11, *) {
            navigationBar.largeTitleTextAttributes = [
                .font: provider.preferredNavigationBarLargeTitleFont,
                .foregroundColor: provider.preferredNavigationBarLargeTitleColor
            ]
        }
        
        setNavigationBarHidden(provider.prefersNavigationBarHidden, animated: animated)
        
        if provider.prefersNavigationBarTransparent {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            // navigationBar.isTranslucent = true
        }
        else {
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
            // navigationBar.isTranslucent = false
        }
        
        let backButtonImage = provider.preferredNavigationBarBackButtonImage?.withRenderingMode(.alwaysTemplate)
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        
        let backButtonTitle = provider.preferredNavigationBarBackButtonTitle ?? ""
        let backItem = UIBarButtonItem(title: backButtonTitle, style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        _vc.navigationItem.backBarButtonItem = backItem
        sourceVC?.navigationItem.backBarButtonItem = backItem
        
    }
    
    func setNeedsNavigationBarAppearanceUpdate() {
        
        guard let vc = self.topViewController else { return }
        
        let sourceIndex = (viewControllers.count - 2)
        let sourceVC = (sourceIndex >= 0) ? viewControllers[sourceIndex] : nil
        update(with: vc, sourceVC: sourceVC, animated: true)
        
    }
    
    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        
        if let vc = viewControllers.last, viewControllers.count > 0 {
            
            guard let _ = vc as? UINavigationBarAppearanceProvider else {
                super.setViewControllers(viewControllers, animated: animated)
                return
            }
            
            let sourceIndex = (viewControllers.count - 2)
            let sourceVC = (sourceIndex >= 0) ? viewControllers[sourceIndex] : nil
            update(with: vc, sourceVC: sourceVC, animated: false)
            
        }
        
        super.setViewControllers(viewControllers, animated: animated)
        
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewController is UINavigationBarAppearanceProvider {
            update(with: viewController, sourceVC: self.topViewController, animated: animated)
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        
        if let topVC = topViewController, let index = viewControllers.index(of: topVC) {
            
            guard (index - 1) >= 0 else { return super.popViewController(animated: animated) }
            
            let vc = viewControllers[index-1]
            update(with: vc, sourceVC: topVC, animated: animated)
            
        }
        
        return super.popViewController(animated: animated)
        
    }
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        guard viewControllers.count > 0 else { return super.popToRootViewController(animated: animated) }
        
        let viewController = viewControllers[0]
        update(with: viewController, sourceVC: self.topViewController, animated: animated)
        
        return super.popToRootViewController(animated: animated)
        
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        update(with: viewController, sourceVC: self.topViewController, animated: animated)
        return super.popToViewController(viewController, animated: animated)
        
    }
    
}
