//
//  ConstraintMakerRelatable+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import Foundation
import SnapKit

public extension ConstraintMakerRelatable {

    @discardableResult
    public func smartEqualTo(_ other: ConstraintRelatableTarget, _ file: String = #file, _ line: UInt = #line) -> Void /* ConstraintMakerEditable */ {
        
        print("Smart equal to:")
        
        let mirror = Mirror(reflecting: self)
        for (name, value) in mirror.children {
            print("\(name): \(value)")
        }
        
        // return self.relatedTo(other, relation: .equal, file: file, line: line)
        
    }

}
