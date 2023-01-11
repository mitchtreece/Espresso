//
//  TriggerPublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// A wrapped publisher that only outputs `Void` values.
public class TriggerPublisher {
    
    private let subject = GuaranteePassthroughSubject<Void>()
    
    public init() {
        //
    }
    
    public func fire() {
        self.subject.send(())
    }
    
    public func asPublisher() -> GuaranteePublisher<Void> {
        return self.subject.eraseToAnyPublisher()
    }
    
}

