//
//  Bundle+Version.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

public extension Bundle {

    /// The bundle's version.
    ///
    /// If the bundle's info dictionary contains an invalid version
    /// string for it's "CFBundleShortVersionString" key, this will
    /// return an invalid (0.0.0) version.
    var version: Version {

        return (self.infoDictionary?["CFBundleShortVersionString"] as? String)
            .flatMap { try? Version($0) } ?? .invalid

    }

}
