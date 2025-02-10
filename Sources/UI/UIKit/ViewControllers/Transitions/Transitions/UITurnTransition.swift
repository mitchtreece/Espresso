//
//  UITurnTransition.swift
//  EspressoUI
//
//  Created by Mitch on 2/2/25.
//

#if canImport(UIKit)

import UIKit

/// A turning view controller transition.
public class UITurnTransition: UIViewControllerDirectionalTransition {
    
    public override init() {
        
        super.init()

        self.presentationDirection = .right
        self.dismissalDirection = .left
                
    }
    
    public override func animations(using ctx: UIViewControllerTransition.Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        let direction = ctx.operation == .presentation ?
            self.presentationDirection :
            self.dismissalDirection
                
        return UIAnimationGroupController {

            sourceVC.view.frame = context.initialFrame(for: sourceVC)
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.addSubview(destinationVC.view)

            var perspective = CATransform3DIdentity
            perspective.m34 = -0.0015
            container.layer.sublayerTransform = perspective
            
            destinationVC.view.layer.transform = self.rotation(direction: direction.inverted())
            
        } animations: {
      
            let rotation = self.rotation(direction: direction)
            
            return UIAnimation(.simple(.easeIn), duration: (self.duration / 2)) {
                sourceVC.view.layer.transform = rotation
            }
            .then(.simple(.easeOut), duration: (self.duration / 2)) {
                
                destinationVC.view.transform = .identity // Not sure why this is needed
                destinationVC.view.layer.transform = CATransform3DIdentity
                
            }
            
        } completion: {
                   
            container.layer.sublayerTransform = CATransform3DIdentity
            sourceVC.view.layer.transform = CATransform3DIdentity
            destinationVC.view.layer.transform = CATransform3DIdentity
            destinationVC.view.transform = .identity // Not sure why this is needed

            context.completeTransition(!context.transitionWasCancelled)
            
        }
        
    }
    
    private func rotation(direction: Direction) -> CATransform3D {
        
        return switch direction {
        case .up:    rotationTransform3D(.degrees(90), attitude: .pitch)
        case .down:  rotationTransform3D(.degrees(-90), attitude: .pitch)
        case .left:  rotationTransform3D(.degrees(-90), attitude: .yaw)
        case .right: rotationTransform3D(.degrees(90), attitude: .yaw)
        }
        
    }
    
}

#endif
