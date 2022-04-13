//
//  TriggerPublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// A wrapped publisher that only outputs `Void` values.
@available(iOS 13, *)
public class TriggerPublisher {
    
    private let subject = PassthroughSubject<Void, Never>()
    
    public init() {
        //
    }
    
    public func fire() {
        self.subject.send(())
    }
    
    public func asPublisher() -> AnyPublisher<Void, Never> {
        return self.subject.eraseToAnyPublisher()
    }
    
}

