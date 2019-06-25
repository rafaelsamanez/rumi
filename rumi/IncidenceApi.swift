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
    static let groupsUrl = "\(baseUrl)/groups"
    static let getIncidenceByGroupUrl = "\(baseUrl)/groups/5ceff7b6d4274235b808de7b/incidences"
    
    
    
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
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1Y2VmZjcyZWQ0Mjc0MjM1YjgwOGRlNzkiLCJqdGkiOiI1NDM0NTYxYS1jMzkyLTRmYmMtYTdhMi1jNzU4ZWRjZmNjZDAiLCJuYW1laWQiOiJEOEJGMDU0RSIsInJvbGUiOiJST09NRVIiLCJMb2dnZWRPbiI6IjYvMjQvMjAxOSAyOjQzOjQzIEFNIiwibmJmIjoxNTYxMzQ0MjIzLCJleHAiOjE1NjE5NDkwMjMsImlhdCI6MTU2MTM0NDIyMywiaXNzIjoiaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbSIsImF1ZCI6Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20ifQ.oRiKHXj7KFdtlUZahqQZklnmrTtN6fJBam0NGzwcEqI"
            
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
    
    
    
    static func getIncidencesListGroup(
        
        responseHandler:  @escaping ((IncidencesResponse)->(Void)),
        errorHandler: @escaping ((Error)-> Void)){
        
        self.getIncidences(
            from: getIncidenceByGroupUrl,
            responseType: IncidencesResponse.self,
            responseHandler: responseHandler,
            errorHandler: errorHandler)
        
    }
    
    

}
