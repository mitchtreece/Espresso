//
//  JSON.swift
//  Espresso
//
//  Created by Mitch Treece on 1/11/23.
//

import Foundation

/// A json object type representation.
public typealias JSON = [String: Any]

public extension JSON /* Print */ {
    
    /// Debug prints the json object to the console.
    func debugPrint() {
        
        guard let data = asJsonData(options: [.prettyPrinted]),
              let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            
            Swift.debugPrint(self)
            return
            
        }
        
        Swift.debugPrint(string)
        
    }
    
}
