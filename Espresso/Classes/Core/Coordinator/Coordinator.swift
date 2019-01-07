//
//  Coordinator.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

/**
 A coordinator base class.
 
 Coordinators manage view controller display state & presentation. They're used to define an app's navigation flow in chunks;
 while keeping navigation logic separate from view & app logic.
 
 A coordinator should manage the navigation of _only_ what it's concerned with.
 Multiple coordinators can live in a single navigation stack, each managing a set of view controllers in the stack.
 Likewise, a coordinator can be associated with as many (or as few) view controllers as needed.
 
 ```
 class GreenCoordinator: Coordinator {
 
    override func start() -> UIViewController {
 
        let vc = GreenViewController()
        vc.delegate = self
        return vc
 
    }
 
 }
 
 extension GreenCoordinator: GreenViewControllerDelegate {
 
    func didTapDone(_ sender: UIButton) {
        self.finish()
    }
 
 }
 ```
 ```
 class RedCoordinator: Coordinator {
 
    override func start() -> UIViewController {
 
        let vc = RedViewController()
        vc.delegate = self
        return vc
 
    }
 
 }
 
 extension RedCoordinator: RedViewControllerDelegate {
 
    func didTapGreen(_ sender: UIButton) {
 
        let coordinator = GreenCoordinator.in(parent: self)
        self.start(child: coordinator)
 
    }
 
 }
 ```
 */
open class Coordinator: CoordinatorProtocol, Equatable {
    
    public static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
    
    /**
     Representation of a coordinator's various presentation styles.
     */
    public enum PresentationStyle {
        
        /// A presentation style representing no presentation
        case none
        
        /// A modal presentation style
        case modal
        
        /// A navigation push presentation style
        case push
        
    }
    
    // MARK: BaseCoordinatorProtocol
    
    public private(set) var rootViewController: UIViewController
    
    public var isDebugEnabled: Bool {
        return false
    }
    
    // MARK: ChildCoordinatorProtocol
    
    public private(set) weak var parent: BaseCoordinatorProtocol?
    
    // MARK: Internal
    
    internal var presentationStyle: PresentationStyle!
    internal var initialViewController: UIViewController!
    internal var navigationDelegate: CoordinatedNavigationDelegate!
    
    /**
     Initializes a coordinator instance in a parent coordinator.
     - Parameter parent: The parent coordinator.
     - Returns: A `Coordinator` instance.
     */
    public static func `in`(parent: BaseCoordinatorProtocol) -> Self {
        
        let topViewController = UIApplication.shared.keyViewController(in: parent.rootViewController) ?? parent.rootViewController
        return self.init(rootViewController: topViewController, parent: parent)
        
    }
    
    // This should be private. But I can't find a way to do it.
    // Use `Coordinator.in(parent:)` instead
    // SHOULD NOT BE OVERRIDDEN OR USED FROM SUBCLASSES
    required public init(rootViewController: UIViewController, parent: BaseCoordinatorProtocol) {
        
        self.rootViewController = rootViewController
        self.parent = parent
        self.navigationDelegate = CoordinatedNavigationDelegate(coordinator: self)
        
    }
    
    open func start(options: [String: Any]?) -> UIViewController {
        fatalError("Coordinator.start() must be implemented")
    }
    
    /**
     Tells the coordinator's parent that it's finished.
     This will remove the child from the parent's coordinator stack & dismiss it in the same way it was presented.
     */
    public func finish() {
        self.parent?.remove(child: self)
    }
    
}
