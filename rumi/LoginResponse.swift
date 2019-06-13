//
//  LoginResponse.swift
//  rumi
//
//  Created by Israel Matias on 6/12/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    var profile: Profile?
    var role: String?
    var token: String?
}
