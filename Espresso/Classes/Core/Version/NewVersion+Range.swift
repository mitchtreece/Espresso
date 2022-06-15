//
//  Range+NewVersion.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

extension ClosedRange where Bound == Version {
    
    /**
     - Returns: `true` if the provided Version exists within this range.
     - Important: Returns `false` if `version` has prerelease identifiers unless
     the range *also* contains prerelease identifiers.
     */
    public func contains(_ version: Version) -> Bool {
        // Special cases if version contains prerelease identifiers.
        if !version.prerelease.isEmpty, lowerBound.prerelease.isEmpty && upperBound.prerelease.isEmpty {
            // If the range does not contain prerelease identifiers, return false.
            return false
        }

        // Otherwise, apply normal contains rules.
        return version >= lowerBound && version <= upperBound
    }
     
}

extension Range where Bound == Version {
    
    /**
     - Returns: `true` if the provided Version exists within this range.
     - Important: Returns `false` if `version` has prerelease identifiers unless
     the range *also* contains prerelease identifiers.
     */
    public func contains(_ version: Version) -> Bool {
        // Special cases if version contains prerelease identifiers.
        if !version.prerelease.isEmpty {
            // If the range does not contain prerelease identifiers, return false.
            if lowerBound.prerelease.isEmpty && upperBound.prerelease.isEmpty {
                return false
            }

            // At this point, one of the bounds contains prerelease identifiers.
            // Reject 2.0.0-alpha when upper bound is 2.0.0.
            if upperBound.prerelease.isEmpty && upperBound.isRequiredComponenetsEqual(to: version) {
                return false
            }
        }

        // Otherwise, apply normal contains rules.
        return version >= lowerBound && version < upperBound
    }
    
}
