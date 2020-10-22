//
//  HTTPManagerMock.swift
//  IOSSysChallengeTests
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation
@testable import IOSSysChallenge

// MARK: - (Success Returning) Success Decoding Scenerio -

class HTTPManagerMockSuccessReturnOne: HTTPManager {
    
    override func executeRequest<Model: Codable>(request: [String: String] = [:],
                                                 type: HTTPMethod = .GET,
                                                 model: Model.Type,
                                                 urlString: String,
                                                 completionBlock: @escaping (NetworkResult<Model, Error>) -> Void) {
        
        var data = Data()
        var object: Model?
        let userModel = UserModel(success: true, investor: Investor(id: 0,
                                                                investorName: "investorName",
                                                                email: "email",
                                                                name: "name",
                                                                photoUrl: "photoUrl"))
        
        do {
            data = try JSONEncoder().encode(userModel)
        } catch {
            print("Decoding erro in HTTPManagerMock")
        }
        
        do {
            let decoder = JSONDecoder()
            object = try decoder.decode(model, from: data)
        } catch {
            print("Decoding erro in HTTPManagerMock")
        }
        
        completionBlock(.success(model: object, client: "client", token: "token"))
    }
}

// MARK: - (Success Returning) Error Decoding Scenerio -

class HTTPManagerMockSuccessReturnTwo: HTTPManager {
    override func executeRequest<Model: Codable>(request: [String: String] = [:],
                                                 type: HTTPMethod = .GET,
                                                 model: Model.Type,
                                                 urlString: String,
                                                 completionBlock: @escaping (NetworkResult<Model, Error>) -> Void) {
        completionBlock(.failure(error: HTTPError.unknown))
    }
}

// MARK: - Error Returning -

class HTTPManagerMockErrorReturn: HTTPManager {
    override func executeRequest<Model: Codable>(request: [String: String] = [:],
                                                 type: HTTPMethod = .GET,
                                                 model: Model.Type,
                                                 urlString: String,
                                                 completionBlock: @escaping (NetworkResult<Model, Error>) -> Void) {
        completionBlock(.failure(error: NSError(domain: "Test", code: 404, userInfo: nil)))
    }
}
