//
//  PublishedSubjectType.swift
//  Espresso
//
//  Created by Mitch on 1/12/25.
//

import Foundation

// @PublishedReadOnly                -> @PublishedAny
// @PublishedReadOnlyUnique          -> @PublishedAnyUnique
// @PublishedReadOnlyTrigger         -> @PublishedAnyTrigger
// @PublishedGuaranteeReadOnly       -> @PublishedAnyGuarantee
// @PublishedGuaranteeReadOnlyUnique -> @PublishedAnyGuaranteeUnique

/// Representation of the various published
/// property wrapper subject-types.
public enum PublishedSubjectType {
 
    /// Type representing a ``CurrentValueSubject``.
    case value
    
    /// Type representing a ``PassthroughSubject``.
    case passthrough
    
}
