//
//  URL+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 2/19/24.
//

import Foundation

public extension URL {
    
    /// Checks if a local file or remote resource at this url is reachable.
    ///
    /// - parameter timeout: The request timeout. If checking a local file url, this is ignored.
    /// - parameter checkStatus: Flag indicating if the response status-code should be checked against
    /// valid http codes (`200...299`). If checking a local file url, this is ignored.
    /// - returns: A flag indicating if the resource at this url is reachable.
    func reachable(timeout: TimeInterval = 1,
                   checkStatus: Bool = false) async -> Bool {
        
        guard !self.isFileURL else {
            return (try? checkResourceIsReachable()) ?? false
        }
        
        var request = URLRequest(url: self)
        request.timeoutInterval = timeout
        
        do {
            
            let response = try await URLSession
                .shared
                .data(for: request)
            
            guard checkStatus else {
                return true
            }
            
            guard let statusCode = (response.1 as? HTTPURLResponse)?.statusCode else {
                return false
            }
            
            return (200...299)
                .contains(statusCode)
            
        }
        catch {
            return false
        }
        
    }
    
}
