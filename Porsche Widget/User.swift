//
//  User.swift
//  Porsche Widget
//
//  Created by Alpay Kücük on 13.10.22.
//

import Foundation

class User {
    
    var email: String?
    var password: String?
    
    init(email: String? = nil, password: String? = nil) {
        self.email = email
        self.password = password
    }
    
}
