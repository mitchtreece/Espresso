//
//  PublisherError.swift
//  Espresso
//
//  Created by Mitch on 1/10/25.
//

import Foundation

/// Representation of the various publisher errors.
public enum PublisherError: Error {
    
    /// An error representing an invalid subject.
    case invalidSubject
    
    /// An error representing empty value access
    /// of a publisher's output stream.
    case emptyStream
    
}
