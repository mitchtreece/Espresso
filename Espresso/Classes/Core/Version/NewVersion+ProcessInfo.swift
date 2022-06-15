//
//  ProcessInfo+NewVersion.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

public extension ProcessInfo {
    
    /// The version of the operating system on which the process is executing.
    @available(OSX, introduced: 10.10)
    @available(iOS, introduced: 8.0)
    var osVersion: Version {
        
        // NOTE cannot call “super” from an extension that replaces that method
        // tried to use keypaths but couldn’t. This way we are not making the
        // method ambiguous anyway, so probably better.
        
        let version = self.operatingSystemVersion
        
        return Version(
            major: UInt(version.majorVersion),
            minor: UInt(version.minorVersion),
            patch: UInt(version.patchVersion)
        )
        
    }
    
}
