//
//  IncidenceApi.swift
//  rumi
//
//  Created by Rafael on 6/23/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation


import os
import Alamofire



class incidenceApi {
    
    

    static let baseUrl = "https://rumiapi.azurewebsites.net/api/"
    static let getGroupUrl = "\(baseUrl)/groups"
    static let getIncidenceByGroupUrl = "\(baseUrl)/groups"
    static let CreateIncidence = "\(baseUrl)/incidences"
    
    
     static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1Y2VmZjcyZWQ0Mjc0MjM1YjgwOGRlNzkiLCJqdGkiOiJlZTA5NWI5ZS1hNmQ4LTQzYmQtODc3Zi1iMGE5ZTAwOGZiMmUiLCJuYW1laWQiOiJEOEJGMDU0RSIsInJvbGUiOiJST09NRVIiLCJMb2dnZWRPbiI6IjYvMjUvMjAxOSA0OjI4OjU2IFBNIiwibmJmIjoxNTYxNDgwMTM2LCJleHAiOjE1NjIwODQ5MzYsImlhdCI6MTU2MTQ4MDEzNiwiaXNzIjoiaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20ifQ.qaGVJu_xN51ymtjGp4BavI-SyUNgkP11klxWSrM_ACk"
    
    
    static private func getIncidences(
        
        
        from urlString: String,
        responseType: IncidencesResponse.Type,
        responseHandler: @escaping(((IncidencesResponse)->(Void))),
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
        Alamofire.request(url,headers: headers)
            .validate()
            .responseJSON(completionHandler: {response in
                switch response.result {
                case.success(_):
                    
                    do {
                        let decoder = JSONDecoder()
                        if let data = response.data{
                            
                            let dataResponse = try decoder.decode(IncidencesResponse.self,from:data)
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
    
    
    
    static private func getGroupId(
        
        
        from urlString: String,
        responseType: GroupsResponse.Type,
        responseHandler: @escaping(((GroupsResponse)->(Void))),
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
        Alamofire.request(url,headers: headers)
            .validate()
            .responseJSON(completionHandler: {response in
                switch response.result {
                case.success(_):
                    
                    do {
                        let decoder = JSONDecoder()
                        if let data = response.data{
                            
                            let dataResponse = try decoder.decode(GroupsResponse.self,from:data)
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
    
    
    static func getIncidencesListGroup(
        
        idgroup: String,
        responseHandler:  @escaping ((IncidencesResponse)->(Void)),
        errorHandler: @escaping ((Error)-> Void)){
        
        let idgrouprecive = "\(getIncidenceByGroupUrl)/"+idgroup+"/incidences"
        //let getIncidenceByGroupUrl2 = "\(idgrouprecive)/incidences"
        
        
        self.getIncidences(
            from: idgrouprecive,
            responseType: IncidencesResponse.self,
            responseHandler: responseHandler,
            errorHandler: errorHandler)
        
    }
    
    
    static func getGroupId(
        
        responseHandler:  @escaping ((GroupsResponse)->(Void)),
        errorHandler: @escaping ((Error)-> Void)){
        
        self.getGroupId(
            from: getGroupUrl,
            responseType: GroupsResponse.self,
            responseHandler: responseHandler,
            errorHandler: errorHandler)
        
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
