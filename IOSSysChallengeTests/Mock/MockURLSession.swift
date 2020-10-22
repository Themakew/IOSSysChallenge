//
//  MockURLSession.swift
//  IOSSysChallengeTests
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation
@testable import IOSSysChallenge

class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextError: Error?
    var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nil, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private(set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
