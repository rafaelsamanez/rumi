//
//  CreateIncidenceApi.swift
//  rumi
//
//  Created by Rafael on 6/23/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation
import Alamofire

import os

class CreateincidenceApi {
    
    
    
    static let baseUrl = "https://rumiapi.azurewebsites.net/api/"
    static let groupsUrl = "\(baseUrl)/groups"
    static let CreateIncidence = "\(baseUrl)/incidences"
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1Y2VmZjcyZWQ0Mjc0MjM1YjgwOGRlNzkiLCJqdGkiOiIyOTllYTFjYi1jZDI2LTQ4YjUtODY3Ni1iOWRjZjQwOTkwMGYiLCJuYW1laWQiOiJEOEJGMDU0RSIsInJvbGUiOiJST09NRVIiLCJMb2dnZWRPbiI6IjYvMjUvMjAxOSA2OjQ5OjU1IEFNIiwibmJmIjoxNTYxNDQ1Mzk1LCJleHAiOjE1NjIwNTAxOTUsImlhdCI6MTU2MTQ0NTM5NSwiaXNzIjoiaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20ifQ.6Mkndj9t--gxMCTuZuyQad_oGPirMZlkvdyzO3PT_qI"
    
    
    static private func CreateIncidence(
        
        from urlString: String,
        parameters: Parameters,
        responseType: Incidence.Type,
        responseHandler: @escaping(((Incidence)->(Void))),
        errorHandler: @escaping ((Error)->Void)){
        
        //validar url
        guard  let url = URL(string: urlString)else{
            let message = "Error on URL"
            os_log("%@",message)
            return
            
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer  \(token)"
        ]
        
        
        
        //make a request
       
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON(completionHandler: {response in
                switch response.result {
                case.success(_):
                    
                    do {
                        let decoder = JSONDecoder()
                        if let data = response.data{
                            
                            let dataResponse = try decoder.decode(Incidence.self,from:data)
                            responseHandler(dataResponse)
                        }
                        
                    }catch{
                        errorHandler(error)
                        
                        
                    }
                    
                case .failure(let error):
                    errorHandler(error)
                }
                
                
            })
        
        
    }
    
    
    
    static func CreateIncidence(
        
        incidenceRequest: Incidencerequest,
        responseHandler:  @escaping ((Incidence)->(Void)),
        errorHandler: @escaping ((Error)-> Void)){
        
        let parameters: Parameters = [
        
            "GroupId":"5ceff7b6d4274235b808de7b",
            "Description": incidenceRequest.description!
        ]
        
        self.CreateIncidence(
            from: CreateIncidence,
            parameters: parameters,
            responseType: Incidence.self,
            responseHandler: responseHandler,
            errorHandler: errorHandler)
        
    }
    
    
    
}
