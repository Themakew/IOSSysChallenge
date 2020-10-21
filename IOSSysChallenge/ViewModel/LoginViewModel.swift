//
//  LoginViewModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 19/10/20.
//

import Foundation

// MARK: -

class LoginViewModel {
    
    // MARK: - Properties -
    
    var events = UserModel()
    var httpManagerInstance: HTTPManager?
    
    // MARK: - Init -
    
    init(httpManager: HTTPManager?) {
        if let instance = httpManager {
            httpManagerInstance = instance
        }
    }

    // MARK: - Internal Methods -
    
    func makeLogin(request: LoginModel, completion: @escaping (NetworkResult<UserModel, Error>) -> Void) {
        var dictionary: [String: String] = [:]
        
        do {
            dictionary = try JSONDecoder().decode([String: String].self, from: JSONEncoder().encode(request))
        } catch let error {
            completion(.failure(error: error))
        }
        
        httpManagerInstance?.executeRequest(request: dictionary, type: .POST, model: UserModel.self, urlString: EndPoints.login.path, completionBlock: { response in
            switch response {
            case .failure(let error):
                completion(.failure(error: error))
            case let .success(user, client, token):
                AppAuth.shared.signIn(email: request.email,
                                      password: request.password,
                                      client: client,
                                      token: token)
                completion(.success(model: user, client: client, token: token))
            }
        })
    }
    
    func buildLoginList() -> [LoginBaseProtocol] {
        var list = [LoginBaseProtocol]()
        
        list.append(InputTextField(id: 1, title: "Email", textFieldType: .email))
        list.append(InputTextField(id: 2, title: "Senha", textFieldType: .password))
        list.append(OneButton(title: "ENTRAR"))
        
        return list
    }
    
    func getLoginModelObject(email: String, password: String) -> LoginModel {
        return LoginModel(email: email, password: password)
    }
}
