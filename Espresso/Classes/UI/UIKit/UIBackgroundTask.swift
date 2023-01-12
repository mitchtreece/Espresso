//
//  UIBackgroundTask.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import UIKit

/// Wrapper class over `UIApplication` background task execution.
public class UIBackgroundTask {

    /// Representation of the various states a background task can be in.
    public enum State {

        /// A pending state.
        case pending
        
        /// A started state.
        case started
        
        /// A finished state.
        case finished
        
        /// A cancelled state.
        case cancelled
        
        /// An expired state.
        case expired

    }

    private var taskId: UIBackgroundTaskIdentifier?
    private var expiration: (()->())?
    private var completion: (()->())?

    /// The background task's state.
    public private(set) var state: State = .pending

    /// Initializes a background task with given expiration & completion blocks.
    ///
    /// - parameter expiration: An expiration block.
    /// - parameter completion: A completion block.
    public init(expiration: (()->())? = nil,
                completion: (()->())? = nil) {

        self.expiration = expiration
        self.completion = completion

    }

    /// Starts the background task.
    ///
    /// - returns: The background task.
    @discardableResult
    public func start() -> Self {

        guard self.state == .pending else { return self }
        
        self.state = .started

        self.taskId = UIApplication.shared.beginBackgroundTask(expirationHandler: { [weak self] in
            self?.state = .expired
            self?.expiration?()
        })

        return self

    }

    /// Cancels the background task.
    public func cancel() {

        guard let taskId = self.taskId,
              self.state == .started else {
            
            self.state = .cancelled
            return
            
        }

        self.state = .cancelled
        
        UIApplication
            .shared
            .endBackgroundTask(taskId)
        
    }

    /// Finishes the background task.
   public func finish() {

        guard let taskId = self.taskId,
            self.state == .started else { return }

        self.state = .finished

        UIApplication
            .shared
            .endBackgroundTask(taskId)

        self.completion?()

    }

    deinit {
        cancel()
    }

}
