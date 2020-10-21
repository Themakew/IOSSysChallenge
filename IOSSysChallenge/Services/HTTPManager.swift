//
//  HTTPManager.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import Foundation

// MARK: - Enum -

enum HTTPError: Error {
    case invalidURL
    case invalidResponse
    case unknown
}

enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
}

enum NetworkResult<Model, Error> {
    case success(model: Model?, client: String, token: String)
    case failure(error: Error)
}

// MARK: - LocalizedError -

extension HTTPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "service_url_error".text()
        case .invalidResponse, .unknown:
            return "unknown_error".text()
        }
    }
}

// MARK: - Protocol -

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

// MARK: -

class HTTPManager {
    
    // MARK: - Properties -
    
    private let session: URLSessionProtocol
    
    // MARK: - Init -
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Internal Methods -

    func executeRequest<Model: Codable>(request: [String: String] = [:],
                        type: HTTPMethod = .GET,
                        model: Model.Type,
                        urlString: String,
                        completionBlock: @escaping (NetworkResult<Model, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(error: HTTPError.invalidURL))
            return
        }
        
        let requestDictionary = createURLRequest(request: request, type: type, url: url)
        var object: Model?
        var client: String?
        var token: String?
        
        let task = session.dataTask(with: requestDictionary) { data, response, error in
            do {
                guard error == nil else {
                    completionBlock(.failure(error: error!))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(error: HTTPError.invalidResponse))
                    return
                }
                
                if let dataFromAPI = data {
                    let decoder = JSONDecoder()
                    object = try decoder.decode(model, from: dataFromAPI)
                    
                    if let httpUrlResponse = response as? HTTPURLResponse {
                        client = httpUrlResponse.allHeaderFields["client"] as? String
                        token = httpUrlResponse.allHeaderFields["access-token"] as? String
                    }
                }
                
                if let jsonString = String(data: data ?? Data(), encoding: .utf8) {
                    print(jsonString)
                }
                
                completionBlock(.success(model: object, client: client ?? "", token: token ?? ""))
            } catch {
                completionBlock(.failure(error: HTTPError.unknown))
            }
        }
        task.resume()
    }
    
    // MARK: - Private Methods -
    
    private func createURLRequest(request: [String: String], type: HTTPMethod, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        
        guard type == .POST, let httpBody = try? JSONSerialization.data(withJSONObject: request, options: []) else {
            urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(AppAuth.shared.auth?.token ?? "", forHTTPHeaderField: "access-token")
            urlRequest.setValue(AppAuth.shared.auth?.client ?? "", forHTTPHeaderField: "client")
            urlRequest.setValue(AppAuth.shared.auth?.uid ?? "", forHTTPHeaderField: "uid")
            return urlRequest
        }
        
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = httpBody
        return urlRequest
    }
}
