////
////  Bundle+Version.swift
////  Espresso
////
////  Created by Mitch Treece on 6/14/22.
////
//
//import Foundation
//
//public extension Bundle {
//
//    /// The bundle's version.
//    var version: Version? {
//
//        if let bundleVersion = self.infoDictionary?["CFBundleShortVersionString"] as? String {
//            return try? Version(bundleVersion)
//        }
//
//        return nil
//
//    }
//
//}
