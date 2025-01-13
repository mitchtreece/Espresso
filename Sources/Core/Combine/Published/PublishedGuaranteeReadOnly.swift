//
//  PublishedGuaranteeReadOnly.swift
//  Espresso
//
//  Created by Mitch on 1/12/25.
//

import Combine

/// Property wrapper that internally publishes values using a
/// guarantee subject, and externally exposes a read-only ``AnyPublisher``.
///
/// ```swift
/// @PublishedGuaranteeReadOnly<Int>(0) var value
/// @PublishedGuaranteeReadOnly<Int> var onValue
///
/// value.sink {
///     print("CurrentValueSubject: \($0)")
/// }
///
/// onValue.sink {
///     print("PassthroughSubject: \($0)")
/// }
///
/// _value.send(1)
/// _value.send(2)
/// _value.send(3)
///
/// // → "CurrentValueSubject: 0"
/// // → "CurrentValueSubject: 1"
/// // → "CurrentValueSubject: 2"
/// // → "CurrentValueSubject: 3"
///
/// _onValue.send(0)
/// _onValue.send(1)
/// _onValue.send(2)
/// _onValue.send(3)
///
/// // → "PassthroughSubject: 0"
/// // → "PassthroughSubject: 1"
/// // → "PassthroughSubject: 2"
/// // → "PassthroughSubject: 3"
/// ```
@propertyWrapper
public final class PublishedGuaranteeReadOnly<T> {
    
    /// The wrapped subject type.
    public let subjectType: PublishedSubjectType
    
    private let valueSubject: GuaranteeValueSubject<T>?
    private let passthroughSubject: GuaranteePassthroughSubject<T>?
    
    /// The wrapped subject's value.
    /// This throws an error if the internal subject-type is `passthrough`.
    public var value: T {
        get throws {
            
            guard self.subjectType == .value else {
                throw PublisherError.invalidSubject
            }
            
            return self.valueSubject!.value
            
        }
    }
    
    /// The wrapped read-only publisher.
    public var wrappedValue: GuaranteePublisher<T> {
        return self.subject.eraseToAnyPublisher()
    }
    
    private var subject: any Subject<T, Never> {
        
        switch self.subjectType {
        case .value: return self.valueSubject!
        case .passthrough: return self.passthroughSubject!
        }
        
    }
    
    /// Initializes a published guarantee read-only value.
    /// - property value: The initial value to give the underlying subject.
    ///
    /// - Note: Initialization via this function creates a ``GuaranteeValueSubject``,
    ///   and sets the ``subjectType`` to ``value``.
    public init(_ value: T) {
        
        self.subjectType = .value
        self.valueSubject = .init(value)
        self.passthroughSubject = nil
        
    }
    
    /// Initializes a published guarantee read-only passthrough.
    ///
    /// - Note: Initialization via this function creates a ``GuaranteePassthroughSubject``,
    ///   and sets the ``subjectType`` to ``passthrough``.
    public init() {
        
        self.subjectType = .passthrough
        self.valueSubject = nil
        self.passthroughSubject = .init()
        
    }
    
    /// Sends a value to subscribers.
    public func send(_ value: T) {
        self.subject.send(value)
    }
    
    /// The wrapped subject's value _or_ a default value
    /// if accessing `value` would throw an error, or result in `nil`.
    public func value(or default: T) -> T {
        return (try? self.value) ?? `default`
    }
    
}
