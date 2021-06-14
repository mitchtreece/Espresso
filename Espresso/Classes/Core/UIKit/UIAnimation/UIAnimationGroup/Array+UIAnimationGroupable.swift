//
//  Array+UIAnimationGroupable.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/21.
//

import Foundation

extension Array: UIAnimationGroupable where Element: UIAnimation {
    
    public func asAnimationGroup() -> UIAnimationGroup {
        return UIAnimationGroup(animations: self)
    }
    
}
