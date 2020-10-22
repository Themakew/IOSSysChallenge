//
//  MockURLSessionWithError.swift
//  IOSSysChallengeTests
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation
@testable import IOSSysChallenge

class MockURLSessionWithError: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextError: Error?
    var lastURL: URL?
    
    func failHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nil, failHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
}
