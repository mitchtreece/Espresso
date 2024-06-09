//
//  View+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 10/17/22.
//

import SwiftUI

public extension View /* Appear */ {
    
    /// Adds an action to perform after this view appears.
    /// - parameter action: The action to perform.
    /// - returns: A view that triggers an action after it appears.
    ///
    /// The action is not *actually* triggered when the view finishes appearing.
    /// The system does not provide us a hook for this event. Instead,
    /// this simply waits a duration approximately the same as the system's
    /// default appearance transition animation.
    func onDidAppear(_ action: @escaping ()->Void) -> some View {
        
        onAppear {
            
            Task {
                
                let duration = UInt64(0.5 * 1_000_000_000)
                
                try await Task
                    .sleep(nanoseconds: duration)
                
                action()
                
            }
            
        }
        
    }
    
}

public extension View /* Any */ {
    
    /// Gets a type-erased representation of this view.
    /// - returns: A type-erased `AnyView`.
    func asAnyView() -> AnyView {
        return AnyView(self)
    }
    
}

#if canImport(UIKit)

public extension View /* Hosting */ {
    
    /// Returns the view as a `UIKit`-hosted controller representation.
    /// - returns: A `UIHostingController` instance over the receiver.
    func asHostingController() -> UIHostingController<Self> {
        return UIHostingController(rootView: self)
    }
    
}

#endif

public extension View /* Control Flow */ {
    
    /// Control-flow view-builder that executes actions based on a condition.
    /// - parameter condition: The condition.
    /// - parameter onTrue: An optional action executed when the condition succeeds.
    /// - parameter onFalse: An optional action executed when the condition fails.
    /// - returns: A view.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, 
                             onTrue: ((Self)->Content)?,
                             onFalse: ((Self)->Content)? = nil) -> some View {
                
        if onTrue == nil && onFalse == nil {
            self
        }
        else {
            
            condition ?
                onTrue?(self) :
                onFalse?(self)
            
        }
        
    }
    
    /// Shows the view based on a condition.
    /// - parameter condition: The show condition.
    /// - returns: The view.
    func visible(if condition: Bool) -> some View {
        return opacity(condition ? 1 : 0)
    }
    
    /// Hides the view based on a condition.
    /// - parameter condition: The hide condition.
    /// - returns: The view.
    func hidden(if condition: Bool) -> some View {
        return opacity(condition ? 0 : 1)
    }
    
}

public extension View /* Notifications */ {
    
    /// View notification observer that executes an action when received.
    /// - parameter name: The notification name to observe.
    /// - parameter object: An optional object to pass to the notification center.
    /// - parameter action: The action to execute when received.
    /// - returns: A view that triggers an action when an observed notification is received.
    func onNotification(name: Notification.Name,
                        object: AnyObject? = nil,
                        action: @escaping (Notification)->Void) -> some View {
        
        let publisher = NotificationCenter
            .default
            .publisher(
                for: name,
                object: object
            )
        
        return onReceive(publisher) { notification in
            action(notification)
        }
        
    }
    
}
