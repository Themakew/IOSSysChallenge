//
//  SearchCompaniesViewModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation

// MARK: -

class SearchCompaniesViewModel {
    
    // MARK: - Properties -
    
    var events = CompanyModel()
    var httpManagerInstance: HTTPManager?
    
    // MARK: - Init -
    
    init(httpManager: HTTPManager?) {
        if let instance = httpManager {
            httpManagerInstance = instance
        }
    }

    // MARK: - Internal Methods -

    func getCompany(completion: @escaping (NetworkResult<CompanyModel, Error>) -> Void) {
        httpManagerInstance?.executeRequest(type: .GET, model: CompanyModel.self, urlString: EndPoints.research.path, completionBlock: { response in
            switch response {
            case .failure(let error):
                completion(.failure(error: error))
            case let .success(user, client, token):
                completion(.success(model: user, client: client, token: token))
            }
        })
    }
}
