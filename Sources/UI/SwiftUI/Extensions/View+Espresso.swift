//
//  View+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 10/17/22.
//

import SwiftUI

public extension View /* Hosting */ {
    
    /// Returns the view as a `UIKit`-hosted view representation.
    ///
    /// - returns: A `UIHostingView` instance over the receiver.
    func asHostingView() -> UIHostingView<Self> {
        return UIHostingView(content: self)
    }
    
    /// Returns the view as a `UIKit`-hosted controller representation.
    ///
    /// - returns: A `UIHostingController` instance over the receiver.
    func asHostingController() -> UIHostingController<Self> {
        return UIHostingController(rootView: self)
    }
    
}

public extension View /* Control Flow */ {
    
    /// Control-flow view-builder that executes actions based on a condition.
    ///
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
    
}

public extension View /* Notifications */ {
    
    /// View notification observer that executes an action when received.
    ///
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
