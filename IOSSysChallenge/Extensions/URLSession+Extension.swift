//
//  URLSession+Extension.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation

// MARK: -

extension URLSession: URLSessionProtocol {
    
    // MARK: - Public Methods -
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

// MARK: -

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
