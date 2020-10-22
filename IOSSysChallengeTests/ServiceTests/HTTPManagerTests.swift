//
//  HTTPManagerTests.swift
//  IOSSysChallengeTests
//
//  Created by Ruyther Costa on 21/10/20.
//

import XCTest
@testable import IOSSysChallenge

class HTTPManagerTests: XCTestCase {
    
    var httpManager: HTTPManager!
    var secondHttpManager: HTTPManager!
    
    let sessionSuccess = MockURLSession()
    let sessionFail = MockURLSessionWithError()
    var url = "https://mockurl"
    let invalidURL = ""
    
    override func setUp() {
        super.setUp()
        httpManager = HTTPManager(session: sessionSuccess)
        secondHttpManager = HTTPManager(session: sessionFail)
    }
    
    override func tearDown() {
        httpManager = nil
        url = ""
        httpManager = nil
        super.tearDown()
    }
    
    func testRequestWithURL() {
        let requestURL = URL(string: url)
        
        executeRequest()
        
        XCTAssertTrue(sessionSuccess.lastURL == requestURL)
    }
    
    func testRequestResumeCall() throws {
        let dataTask = MockURLSessionDataTask()
        sessionSuccess.nextDataTask = dataTask
        
        executeRequest()
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testRequestWithError() throws {
        var actualError: String = ""
        
        sessionSuccess.nextError = NSError(domain: "", code: 404, userInfo: nil) as Error
        
        httpManager.executeRequest(model: UserModel.self, urlString: url) { result in
            switch result {
            case .failure(let error):
                actualError = error.localizedDescription
            case .success:
                XCTFail("TestRequestWithError failed.")
            }
        }
        
        XCTAssertTrue(actualError == "The operation couldn’t be completed. ( error 404.)")
    }
    
    func testRequestWithErrorInReturn() throws {
        var actualError: Error?
        
        secondHttpManager.executeRequest(model: UserModel.self, urlString: url) { result in
            switch result {
            case .failure(let error):
                actualError = error
            case .success:
                XCTFail("TestRequestWithErrorInReturn failed.")
            }
        }
        
        XCTAssertTrue(actualError?.localizedDescription == "Sistema indisponível, por favor tente novamente.")
    }
    
    func testRequestWithInvalidURLRequest() throws {
        var actualError: Error?
        
        httpManager.executeRequest(model: UserModel.self, urlString: invalidURL) { result in
            switch result {
            case .failure(let error):
                actualError = error
            case .success:
                XCTFail("TestRequestWithInvalidURLRequest failed.")
            }
        }
        
        XCTAssertTrue(actualError?.localizedDescription == "Url inválida, tente novamente.")
    }
    
    func executeRequest() {
        httpManager.executeRequest(model: UserModel.self, urlString: url) { result in
            // Return data
        }
    }
}
