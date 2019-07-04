//
//  UIStyledNavigationController.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

/**
 A `UINavigationController` subclass that implements common appearance properties.
 */
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
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Style initial view controller
        
        if let vc = viewControllers.first, vc is UINavigationBarAppearanceProvider, viewControllers.count > 0 {
            update(with: vc, sourceVC: nil, animated: false)
        }
        
    }
    
    private func update(with vc: UIViewController, sourceVC: UIViewController?, animated: Bool) {
        
        let sbAppearance = (vc as? UIStatusBarAppearanceProvider)?.preferredStatusBarAppearance
        let lastSbAppearance = (sourceVC as? UIStatusBarAppearanceProvider)?.preferredStatusBarAppearance
        let defaultSbAppearance = UIStatusBarAppearance()
        
        statusBarStyle = sbAppearance?.style ?? lastSbAppearance?.style ?? defaultSbAppearance.style
        statusBarHidden = sbAppearance?.hidden ?? lastSbAppearance?.hidden ?? defaultSbAppearance.hidden
        statusBarAnimation = sbAppearance?.animation ?? lastSbAppearance?.animation ?? defaultSbAppearance.animation
        setNeedsStatusBarAppearanceUpdate()
        
        let nbAppearance = (vc as? UINavigationBarAppearanceProvider)?.preferredNavigationBarAppearance
        let lastNbAppearance = (sourceVC as? UINavigationBarAppearanceProvider)?.preferredNavigationBarAppearance
        let defaultNbAppearance = UINavigationBarAppearance()
        
        navigationBar.barTintColor = nbAppearance?.barColor ?? lastNbAppearance?.barColor ?? defaultNbAppearance.barColor
        navigationBar.tintColor = nbAppearance?.itemColor ?? lastNbAppearance?.itemColor ?? defaultNbAppearance.itemColor
        navigationBar.titleTextAttributes = [
            .font: nbAppearance?.titleFont ?? lastNbAppearance?.titleFont ?? defaultNbAppearance.titleFont,
            .foregroundColor: nbAppearance?.titleColor ?? lastNbAppearance?.titleColor ?? defaultNbAppearance.titleColor
        ]
        
        if #available(iOS 11, *) {
            
            let displayMode = nbAppearance?.largeTitleDisplayMode ?? lastNbAppearance?.largeTitleDisplayMode ?? .automatic
            vc.navigationItem.largeTitleDisplayMode = displayMode
            navigationBar.prefersLargeTitles = (displayMode != .never)
            
            let titleColor = nbAppearance?.largeTitleColor ??
                lastNbAppearance?.largeTitleColor ??
                nbAppearance?.titleColor ??
                lastNbAppearance?.titleColor ??
                defaultNbAppearance.largeTitleColor
            
            navigationBar.largeTitleTextAttributes = [
                .font: (nbAppearance?.largeTitleFont ?? lastNbAppearance?.largeTitleFont ?? defaultNbAppearance.largeTitleFont) as Any,
                .foregroundColor: titleColor
            ]
            
        }
        
        let hidden = (nbAppearance?.hidden ?? lastNbAppearance?.hidden ?? defaultNbAppearance.hidden)
        setNavigationBarHidden(hidden, animated: animated)
        
        if nbAppearance?.transparent ?? lastNbAppearance?.transparent ?? false {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
        else {
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
        }
        
        if nbAppearance?.backButtonHidden ?? defaultNbAppearance.backButtonHidden {
            
            navigationBar.backIndicatorImage = UIImage()
            navigationBar.backIndicatorTransitionMaskImage = UIImage()
            
            let backItem = UIBarButtonItem(title: nil, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
            vc.navigationItem.backBarButtonItem = backItem
            sourceVC?.navigationItem.backBarButtonItem = backItem
            
        }
        else {
            
            if var image = nbAppearance?.backButtonImage ?? lastNbAppearance?.backButtonImage {
                image = image.withRenderingMode(.alwaysTemplate)
                navigationBar.backIndicatorImage = image
                navigationBar.backIndicatorTransitionMaskImage = image
            }
            
            if let title = nbAppearance?.backButtonTitle {
                let backItem = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
                vc.navigationItem.backBarButtonItem = backItem
                sourceVC?.navigationItem.backBarButtonItem = backItem
            }
            
        }
        
    }
    
    /**
     Tells the navigation controller to re-draw it's navigation bar.
     */
    public func setNeedsNavigationBarAppearanceUpdate() {
        
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
        
        if let topVC = topViewController, let index = viewControllers.firstIndex(of: topVC) {
            
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
