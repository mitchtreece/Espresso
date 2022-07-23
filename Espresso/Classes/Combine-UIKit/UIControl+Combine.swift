//
//  UIControl+Combine.swift
//  Espresso
//
//  Created by Mitch Treece on 4/12/22.
//

import UIKit
import Combine

public extension UIControl {
    
    /// A publisher that emits when a given `UIControl.Event` is received.
    func eventPublisher(for events: Event) -> GuaranteePublisher<Void> {
        
        return Publishers.UIControlEvent(
            control: self,
            events: events
        )
        .eraseToAnyPublisher()
        
    }

}

public extension Publishers {
    
    /// A `UIControl` event publisher.
    struct UIControlEvent<C: UIControl>: Publisher {
        
        public typealias Output = Void
        public typealias Failure = Never

        private let control: C
        private let events: C.Event

        public init(control: C,
                    events: C.Event) {
            
            self.control = control
            self.events = events
            
        }
        
        public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {

            subscriber.receive(subscription: Subscription(
                subscriber: subscriber,
                control: self.control,
                events: self.events
            ))
            
        }
        
    }
    
    /// A `UIControl` property publisher.
    struct UIControlProperty<C: UIControl, V>: Publisher {
        
        public typealias Output = V
        public typealias Failure = Never

        private let control: C
        private let events: C.Event
        private let keyPath: KeyPath<C, V>

        public init(control: C,
                    events: C.Event,
                    keyPath: KeyPath<C, V>) {
            
            self.control = control
            self.events = events
            self.keyPath = keyPath
            
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            
            subscriber.receive(subscription: Subscription(
                subscriber: subscriber,
                control: self.control,
                events: self.events,
                keyPath: self.keyPath
            ))
            
        }
        
    }
    
    /// A target-action publisher.
    struct TargetAction<C: AnyObject>: Publisher {
        
        public typealias Output = Void
        public typealias Failure = Never
        
        public typealias AddTargetAction = (C, AnyObject, Selector)->()
        public typealias RemoveTargetAction = (C?, AnyObject, Selector)->()

        private let control: C
        private let addTargetAction: AddTargetAction
        private let removeTargetAction: RemoveTargetAction
        
        public init(control: C,
                    addTargetAction: @escaping AddTargetAction,
                    removeTargetAction: @escaping RemoveTargetAction) {
            
            self.control = control
            self.addTargetAction = addTargetAction
            self.removeTargetAction = removeTargetAction
            
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
            
            subscriber.receive(subscription: Subscription(
                subscriber: subscriber,
                control: self.control,
                addTargetAction: self.addTargetAction,
                removeTargetAction: self.removeTargetAction
            ))
            
        }
        
    }
    
}

public extension Publishers.UIControlEvent {
    
    private final class Subscription<S: Subscriber, C: UIControl>: Combine.Subscription where S.Input == Void {
        
        private var subscriber: S?
        private weak var control: C?
        private let events: C.Event
        
        internal init(subscriber: S,
                      control: C,
                      events: C.Event) {
            
            self.subscriber = subscriber
            self.control = control
            self.events = events
            
            control.addTarget(
                self,
                action: #selector(onEvent),
                for: events
            )
            
        }
        
        public func request(_ demand: Subscribers.Demand) {
            
            // Do nothing here as we only want to send events when they occur.
            // https://developer.apple.com/documentation/combine/subscribers/demand
            
        }
        
        public func cancel() {
            
            self.subscriber = nil
            
            self.control?.removeTarget(
                self,
                action: #selector(onEvent),
                for: self.events
            )
            
        }
        
        @objc private func onEvent() {
            _ = self.subscriber?.receive()
        }
        
    }
    
}

public extension Publishers.UIControlProperty {

    private final class Subscription<S: Subscriber, C: UIControl, V>: Combine.Subscription where S.Input == V {
        
        private var subscriber: S?
        private weak var control: C?
        let keyPath: KeyPath<C, V>
        
        private var didEmit = false
        private let events: C.Event

        init(subscriber: S,
             control: C,
             events: C.Event,
             keyPath: KeyPath<C, V>) {
            
            self.subscriber = subscriber
            self.control = control
            self.events = events
            self.keyPath = keyPath
            
            control.addTarget(
                self,
                action: #selector(onEvent),
                for: events
            )
            
        }

        func request(_ demand: Subscribers.Demand) {
            
            guard let subscriber = self.subscriber,
                  let control = self.control,
                  !self.didEmit else { return }

            guard !self.didEmit && demand > .none else { return }
            
            _ = subscriber.receive(control[keyPath: self.keyPath])
            
            self.didEmit = true
            
        }

        func cancel() {
            
            self.subscriber = nil
            
            self.control?.removeTarget(
                self,
                action: #selector(onEvent),
                for: self.events
            )
            
        }

        @objc private func onEvent() {
            
            guard let control = self.control else { return }
            _ = self.subscriber?.receive(control[keyPath: self.keyPath])
            
        }
        
    }

}

public extension Publishers.TargetAction {
    
    private final class Subscription<S: Subscriber, C: AnyObject>: Combine.Subscription where S.Input == Void {
        
        public typealias AddTargetAction = (C, AnyObject, Selector)->()
        public typealias RemoveTargetAction = (C?, AnyObject, Selector)->()
        
        private var subscriber: S?
        private weak var control: C?
        private let removeTargetAction: RemoveTargetAction

        init(subscriber: S,
             control: C,
             addTargetAction: @escaping AddTargetAction,
             removeTargetAction: @escaping RemoveTargetAction) {
            
            self.subscriber = subscriber
            self.control = control
            self.removeTargetAction = removeTargetAction

            addTargetAction(
                control,
                self,
                #selector(onAction)
            )
            
        }

        func request(_ demand: Subscribers.Demand) {
            
            // We don't care about the demand at this point.
            // As far as we're concerned - The control's target events are endless until it is deallocated.
            
        }

        func cancel() {
            
            self.subscriber = nil
            
            self.removeTargetAction(
                self.control,
                self,
                #selector(onAction)
            )
            
        }

        @objc private func onAction() {
            _ = self.subscriber?.receive()
        }
        
    }
    
}
