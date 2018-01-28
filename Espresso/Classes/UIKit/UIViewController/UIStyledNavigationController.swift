//
//  UIStyledNavigationController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public class UIStyledNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    private var statusBarStyle: UIStatusBarStyle = .default
    private var statusBarHidden: Bool = false
    private var statusBarAnimation: UIStatusBarAnimation = .fade
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    public override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return statusBarAnimation
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
        
        let statusBarAppearance = (vc as? UIStatusBarAppearanceProvider)?.preferredStatusBarAppearance
        let lastStatusBarAppearance = (sourceVC as? UIStatusBarAppearanceProvider)?.preferredStatusBarAppearance
        let defaultStatusBarAppearance = UIStatusBarAppearance()
        
        statusBarStyle = statusBarAppearance?.style ?? lastStatusBarAppearance?.style ?? defaultStatusBarAppearance.style
        statusBarHidden = statusBarAppearance?.hidden ?? lastStatusBarAppearance?.hidden ?? defaultStatusBarAppearance.hidden
        statusBarAnimation = statusBarAppearance?.animation ?? lastStatusBarAppearance?.animation ?? defaultStatusBarAppearance.animation
        setNeedsStatusBarAppearanceUpdate()
        
        let navAppearance = (vc as? UINavigationBarAppearanceProvider)?.preferredNavigationBarAppearance
        let lastNavAppearance = (sourceVC as? UINavigationBarAppearanceProvider)?.preferredNavigationBarAppearance
        let defaultNavAppearance = UINavigationBarAppearance()
        
        navigationBar.barTintColor = navAppearance?.barColor ?? lastNavAppearance?.barColor ?? defaultNavAppearance.barColor
        navigationBar.tintColor = navAppearance?.itemColor ?? lastNavAppearance?.itemColor ?? defaultNavAppearance.itemColor
        navigationBar.titleTextAttributes = [
            .font: navAppearance?.titleFont ?? lastNavAppearance?.titleFont ?? defaultNavAppearance.titleFont,
            .foregroundColor: navAppearance?.titleColor ?? lastNavAppearance?.titleColor ?? defaultNavAppearance.titleColor
        ]
        
        if #available(iOS 11, *) {
            
            let displayMode = navAppearance?.largeTitleDisplayMode ?? lastNavAppearance?.largeTitleDisplayMode ?? .automatic
            vc.navigationItem.largeTitleDisplayMode = displayMode
            navigationBar.prefersLargeTitles = (displayMode != .never)
            
            let titleColor = navAppearance?.largeTitleColor ??
                lastNavAppearance?.largeTitleColor ??
                navAppearance?.titleColor ??
                lastNavAppearance?.titleColor ??
                defaultNavAppearance.largeTitleColor
            
            navigationBar.largeTitleTextAttributes = [
                .font: (navAppearance?.largeTitleFont ?? lastNavAppearance?.largeTitleFont ?? defaultNavAppearance.largeTitleFont) as Any,
                .foregroundColor: titleColor
            ]
            
        }
        
        let hidden = (navAppearance?.hidden ?? lastNavAppearance?.hidden ?? defaultNavAppearance.hidden)
        setNavigationBarHidden(hidden, animated: animated)
        
        if navAppearance?.transparent ?? lastNavAppearance?.transparent ?? false {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
        else {
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
        }
        
        if navAppearance?.backButtonHidden ?? defaultNavAppearance.backButtonHidden {
            
            navigationBar.backIndicatorImage = UIImage()
            navigationBar.backIndicatorTransitionMaskImage = UIImage()
            
            let backItem = UIBarButtonItem(title: nil, style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            vc.navigationItem.backBarButtonItem = backItem
            sourceVC?.navigationItem.backBarButtonItem = backItem
            
        }
        else {
            
            if var image = navAppearance?.backButtonImage ?? lastNavAppearance?.backButtonImage {
                image = image.withRenderingMode(.alwaysTemplate)
                navigationBar.backIndicatorImage = image
                navigationBar.backIndicatorTransitionMaskImage = image
            }
            
            if let title = navAppearance?.backButtonTitle {
                let backItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: nil, action: nil)
                vc.navigationItem.backBarButtonItem = backItem
                sourceVC?.navigationItem.backBarButtonItem = backItem
            }
            
        }
        
    }
    
    func setNeedsNavigationBarAppearanceUpdate() {
        
        guard let vc = self.topViewController else { return }
        
        let sourceIndex = (viewControllers.count - 2)
        let sourceVC = viewControllers[safe: sourceIndex]
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
            
            let vc = viewControllers[index - 1]
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
