//
//  UIBackgroundTask.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

#if canImport(UIKit)

import UIKit

protocol UIBackgroundTaskResolverDelegate: AnyObject {
    
    func onFulfilled(_ resolver: UIBackgroundTaskResolver)
    func onRejected(_ resolver: UIBackgroundTaskResolver, error: Error?)
    
}

/// A `UIBackgroundTask` resolver.
public final class UIBackgroundTaskResolver {
    
    private weak var delegate: UIBackgroundTaskResolverDelegate?
    
    init(delegate: UIBackgroundTaskResolverDelegate) {
        self.delegate = delegate
    }
    
    /// Fulfills the resolver.
    public func fulfill() {
        self.delegate?.onFulfilled(self)
    }
    
    /// Rejects the resolver.
    /// - parameter error: The failure error.
    public func reject(_ error: Error? = nil) {
        self.delegate?.onRejected(self, error: error)
    }
    
}

/// Wrapper class over `UIApplication` background task execution.
public final class UIBackgroundTask: UIBackgroundTaskResolverDelegate {
    
    /// Representation of a background task's various states.
    public enum State: Equatable {
        
        /// A pending state.
        case pending
        
        /// A working state.
        case working
        
        /// A finished state.
        case finished(Result)

    }
    
    /// Representation of the various background task results.
    public enum Result: Equatable {
        
        public static func == (lhs: Result, rhs: Result) -> Bool {
            
            switch lhs {
            case .success:   return rhs == .success
            case .expired:   return rhs == .expired
            case .cancelled: return rhs == .cancelled
            case .failure:
                
                switch rhs {
                case .failure: return true
                default: return false
                }
                
            }
            
        }
        
        /// A successful result.
        case success
        
        /// A failure result.
        case failure(Error?)
        
        /// A cancelled result.
        case cancelled
        
        /// An expired result.
        case expired
        
    }
    
    private var id: UIBackgroundTaskIdentifier?
    private let work: (UIBackgroundTaskResolver)->()
    private let completion: ((Result)->())?
    
    /// The background task's state.
    public private(set) var state: State = .pending
    
    private var resolver: UIBackgroundTaskResolver?
    
    deinit {
        cancel()
    }
    
    /// Initializes a background task.
    /// - parameter work: The background work to perform.
    /// - parameter completion: The completion callback.
    public init(_ work: @escaping (UIBackgroundTaskResolver)->(),
                completion: ((Result)->())? = nil) {
        
        self.work = work
        self.completion = completion
        
    }
    
    /// Starts the background task.
    /// - returns: This background task.
    @discardableResult
    public func start() -> Self {
        
        guard self.state == .pending else {
            return self
        }
        
        self.state = .working
        self.resolver = UIBackgroundTaskResolver(delegate: self)
                
        self.id = UIApplication.shared.beginBackgroundTask(expirationHandler: { [weak self] in
            self?.state = .finished(.expired)
            self?.completion?(.expired)
        })
        
        self.work(self.resolver!)
        
        return self
        
    }
    
    /// Cancels the background task.
    public func cancel() {
        
        guard let id, self.state == .working else {
            
            self.state = .finished(.cancelled)
            return
            
        }

        self.state = .finished(.cancelled)
        self.completion?(.cancelled)
        
        UIApplication
            .shared
            .endBackgroundTask(id)
        
    }
    
    // MARK: UIBackgroundTaskResolverDelegate
    
    func onFulfilled(_ resolver: UIBackgroundTaskResolver) {
        
        guard let id, self.state == .working else {
            
            self.state = .finished(.success)
            return
            
        }

        self.state = .finished(.success)
        self.completion?(.success)
        
        UIApplication
            .shared
            .endBackgroundTask(id)
        
    }
    
    func onRejected(_ resolver: UIBackgroundTaskResolver,
                    error: (any Error)?) {
        
        guard let id, self.state == .working else {
            
            self.state = .finished(.failure(error))
            return
            
        }

        self.state = .finished(.failure(error))
        self.completion?(.failure(error))
        
        UIApplication
            .shared
            .endBackgroundTask(id)
        
    }
    
}

#endif
