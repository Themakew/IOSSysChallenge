//
//  LoginViewModelTests.swift
//  IOSSysChallengeTests
//
//  Created by Ruyther Costa on 21/10/20.
//

import XCTest
@testable import IOSSysChallenge

class LoginViewModelTests: XCTestCase {
    
    let sessionSuccess = MockURLSession()
    
    var viewModel: LoginViewModel!
    var httpMockDecodingSuccess: HTTPManagerMockSuccessReturnOne!
    var httpMockDecodingError: HTTPManagerMockSuccessReturnTwo!
    var httpMockErrorReturn: HTTPManagerMockErrorReturn!
    
    override func setUp() {
        super.setUp()

        httpMockDecodingSuccess = HTTPManagerMockSuccessReturnOne(session: sessionSuccess)
        httpMockDecodingError = HTTPManagerMockSuccessReturnTwo(session: sessionSuccess)
        httpMockErrorReturn = HTTPManagerMockErrorReturn(session: sessionSuccess)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testReceiveEventListAndDecode() {
        viewModel = LoginViewModel(httpManager: httpMockDecodingSuccess)
        
        viewModel.makeLogin(request: LoginModel(email: "email", password: "password")) { result in
            switch result {
            case .failure(let error):
                XCTFail("TestGetEventList failed, error: \(error)")
            case let .success(user, _, _):
                XCTAssertEqual(user?.investor?.name, "name")
            }
        }
    }
    
    func testReceiveEventListAndNotDecode() {
        viewModel = LoginViewModel(httpManager: httpMockDecodingError)
        
        viewModel.makeLogin(request: LoginModel(email: "email", password: "password")) { result in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription == "Sistema indisponível, por favor tente novamente.")
            case .success:
                XCTFail("TestGetEventList failed")
            }
        }
    }
    
    func testReceiveEventListAndReturnFailure() {
        viewModel = LoginViewModel(httpManager: httpMockErrorReturn)
        
        viewModel.makeLogin(request: LoginModel(email: "email", password: "password")) { result in
            switch result {
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription == "The operation couldn’t be completed. (Test error 404.)")
            case .success:
                XCTFail("TestGetEventList failed")
            }
        }
    }
}
