//
//  AccountApi.swift
//  rumi
//
//  Created by Israel Matias on 6/12/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import Alamofire
import os

class AccountApi {
    static let baseUrlString = "https://rumiapi.azurewebsites.net/api"
    static let signInUrlString = "\(baseUrlString)/account/signin"
    static let signUpUrlString = "\(baseUrlString)/account/signup"
    
    static private func AccountRequest<T: Decodable>(
        urlString: String,
        responseType: T.Type,
        parameters: Parameters,
        responseHandler: @escaping ((T) -> Void),
        errorHandler: @escaping ((Error) -> Void)) {
        
        guard let url = URL(string: urlString) else {
            let message = "Error on URL"
            os_log("%@", message)
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON(
            completionHandler: { response in
                switch response.result {
                case .success( _):
                    do {
                        let decoder = JSONDecoder()
                        if let data = response.data {
                            let dataResponse = try decoder.decode(responseType, from: data)
                            responseHandler(dataResponse)
                        }
                    } catch {
                        errorHandler(error)
                    }
                    
                case .failure(let error):
                    errorHandler(error)
                }
        })
    }
    
    static func signIn(loginRequest: LoginRequest, responseHandler: @escaping ((LoginResponse) -> Void),
                       errorHandler: @escaping ((Error) -> Void)) {
        
        let parameters: Parameters = [
            "email": loginRequest.email,
            "password": loginRequest.password
        ]
        
        self.AccountRequest(urlString: signInUrlString, responseType: LoginResponse.self, parameters: parameters,
                    responseHandler: responseHandler, errorHandler: errorHandler)
    }
    
    static func signUp(registerRequest: RegisterRequest, responseHandler: @escaping ((RegisterResponse) -> Void),
                       errorHandler: @escaping ((Error) -> Void)) {
        
        let parameters: Parameters = [
            "name": registerRequest.name,
            "surname": registerRequest.surname,
            "gender": registerRequest.gender,
            "position": registerRequest.position,
            "email": registerRequest.email,
            "password": registerRequest.password
        ]
        
        self.AccountRequest(urlString: signUpUrlString, responseType: RegisterResponse.self, parameters: parameters,
                    responseHandler: responseHandler, errorHandler: errorHandler)
    }
}
