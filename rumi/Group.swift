//
//  Group.swift
//  rumi
//
//  Created by Rafael on 5/28/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation


struct Group: Codable {
    
    var groupId: String?
    var name: String?
    var owner: String?
    var participants: ParticipantsResponse
    var image: String?
    var active: Bool?
    
 
}
