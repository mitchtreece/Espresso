//
//  Range+NewVersion.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

extension ClosedRange where Bound == Version {
    
    /// - returns: `true` if the provided version exists within this range.
    /// - important: Returns `false` if `version` has pre-release identifiers
    /// **unless** the range *also* contains prerelease identifiers.
    public func contains(_ version: Version) -> Bool {
        
        // Special cases if version contains prerelease identifiers.
        
        if !version.prerelease.isEmpty,
           self.lowerBound.prerelease.isEmpty && self.upperBound.prerelease.isEmpty {
            
            // If the range does not contain prerelease identifiers, return false.
            return false
            
        }

        return version >= self.lowerBound && version <= self.upperBound
        
    }
     
}

extension Range where Bound == Version {
    
    /// - returns: `true` if the provided version exists within this range.
    /// - important: Returns `false` if `version` has prerelease identifiers
    /// **unless** the range *also* contains prerelease identifiers.
    public func contains(_ version: Version) -> Bool {
        
        // Special cases if version contains prerelease identifiers.
        
        if !version.prerelease.isEmpty {
            
            // If the range does not contain prerelease identifiers, return false.
            
            if self.lowerBound.prerelease.isEmpty && self.upperBound.prerelease.isEmpty {
                return false
            }

            // At this point, one of the bounds contains prerelease identifiers.
            // Reject 2.0.0-alpha when upper bound is 2.0.0.
            
            if self.upperBound.prerelease.isEmpty && self.upperBound.isRequiredComponentsEqual(to: version) {
                return false
            }
            
        }

        return version >= self.lowerBound && version < self.upperBound
        
    }
    
}
