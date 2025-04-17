//
//  CustomerModel.swift
//  Rig drills
//
//  Created by Dinesh on 17/04/25.
//

import Foundation
import SwiftData

@Model
class Customer {
    var name: String
    var contactNumber: String
    var alternateContactNumber: String
    var email: String?
    var referalSource: String?
    var country: String
    var address: String?
    
    init(name: String, contactNumber: String, alternateContactNumber: String, email: String? = nil, referalSource: String? = nil, country: String = "India", address: String? = nil) {
        self.name = name
        self.contactNumber = contactNumber
        self.alternateContactNumber = alternateContactNumber
        self.email = email
        self.referalSource = referalSource
        self.country = country
        self.address = address
    }
}
