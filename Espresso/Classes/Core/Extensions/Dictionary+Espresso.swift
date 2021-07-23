//
//  Dictionary+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 3/14/19.
//

import Foundation

public extension Dictionary {
    
    /// Prints the dictionary to the console using a pretty JSON format.
    func debugPrintJSON() {
        
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
            let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
        
        debugPrint(string)
        
    }
    
}
