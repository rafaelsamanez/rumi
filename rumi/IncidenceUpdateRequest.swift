//
//  IncidenceUpdateRequest.swift
//  rumi
//
//  Created by Rafael on 6/25/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation

struct IncidenceUpdaterequest{
    
    
    var Resolved: Bool?
    var Response: String?
    
    init(resolved:Bool, response:String) {
        self.Resolved = resolved
        self.Response = response
        
    }
}
