//
//  KeyboardLayoutGuide.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit
import Combine

/// A layout guide that tracks the keyboard's position.
@available(iOS 13, *)
public class KeyboardLayoutGuide: UILayoutGuide {
    
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var leftConstraint: NSLayoutConstraint!
    private var rightConstraint: NSLayoutConstraint!
    
    private(set) var isKeyboardShown: Bool = false
    
    private var bag: CancellableBag!
    
    init(view: UIView) {
        
        super.init()
        
        view.addLayoutGuide(self)
        
        // Constraints
                
        self.topConstraint = self.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: view.layoutMarginsGuide.layoutFrame.size.height
        )
        
        self.bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        self.leftConstraint = self.leftAnchor.constraint(equalTo: view.leftAnchor)
        self.rightConstraint = self.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        NSLayoutConstraint.activate([
            self.topConstraint,
            self.bottomConstraint,
            self.leftConstraint,
            self.rightConstraint
        ])
        
        // Safe Area Observer
        
        view.onSafeAreaInsetsDidChange = { [weak self] in
            
            guard let window = UIApplication.shared.activeWindow else { return }
            
            self?.layout(
                forKeyboardFrame: window.bounds.bottomEdgeRect,
                in: window
            )
            
        }
        
        // Bindings
        
        setupBindings()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        
        self.bag = CancellableBag()
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .sink { [unowned self] notification in self.keyboardWillChangeFrame(notification) }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [unowned self] _ in self.isKeyboardShown = true }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [unowned self] _ in self.isKeyboardShown = false }
            .store(in: &self.bag)
        
        OrientationProxyViewController.shared
            .viewTransitionPublisher
            .sink { [unowned self] size, transitionCoordinator in
                
                guard !self.isKeyboardShown else { return }
                
                self.viewWillTransition(
                    to: size,
                    with: transitionCoordinator
                )
                
            }
            .store(in: &self.bag)
        
    }
    
    private func keyboardWillChangeFrame(_ notification: Notification) {
        
        guard let window = UIApplication.shared.activeWindow,
              let animation = KeyboardAnimation(notification: notification) else { return }
                
        animate(
            using: animation,
            in: window
        )
        
    }
    
    private func viewWillTransition(to size: CGSize,
                                    with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate { [unowned self] coordinator in
                        
            self.layout(
                forKeyboardFrame: .init(
                    origin: .zero,
                    size: size
                ),
                in: coordinator.containerView
            )
            
        }
        
    }
    
    private func layout(forKeyboardFrame keyboardFrame: CGRect,
                        in coordinateSpace: UICoordinateSpace) {
        
        guard let view = self.owningView else { return }
        
        let keyboardFrameInView = view.convert(
            keyboardFrame,
            from: coordinateSpace
        )
        
        let intersection = view
            .layoutMarginsGuide
            .layoutFrame
            .intersection(keyboardFrameInView)
        
        let frame = intersection.isNull ? view.layoutMarginsGuide.layoutFrame.bottomEdgeRect : intersection
        
        self.topConstraint.constant = frame.minY
        self.bottomConstraint.constant = frame.maxY
        self.leftConstraint.constant = frame.minX
        self.rightConstraint.constant = frame.maxX
        
        view.layoutIfNeeded()
        
    }
    
    private func animate(using animation: KeyboardAnimation,
                         in coordinateSpace: UICoordinateSpace) {
        
        guard animation.duration > 0 else {
            
            layout(
                forKeyboardFrame: animation.endFrame,
                in: coordinateSpace
            )
            
            return
            
        }
        
        layout(
            forKeyboardFrame: animation.beginFrame,
            in: coordinateSpace
        )
        
        animation.animate { [unowned self] in
            
            self.layout(
                forKeyboardFrame: animation.endFrame,
                in: coordinateSpace
            )
            
        }
        
    }
    
}
