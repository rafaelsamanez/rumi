//
//  Incidence.swift
//  rumi
//
//  Created by Rafael on 6/22/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation

struct Incidence: Codable {
    
    var incidenceId: String?
    var groupId: String?
    var description: String?
    var profile : Profile
  
    var resolved :Bool?
    
    var isResolved: Bool {
        get {
            return resolved!
        }
        set {
            resolved = true
        }
    }
    
}
