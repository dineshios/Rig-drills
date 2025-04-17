//
//  EmployeeModel.swift
//  Rig drills
//
//  Created by Dinesh on 17/04/25.
//

import Foundation
import SwiftData

@Model
class Employee {
    var name: String
    var contactNumber: String
    var alternateContactNumber: String
    var email: String?
    var address: String?
    var laungageKnown: String?
    var doj: Date?
    var status: String?
    
    init(name: String, contactNumber: String, alternateContactNumber: String, email: String? = nil, address: String? = nil, laungageKnown: LaungageKnown? = nil, doj: Date? = nil, status: EmployeeStatus? = nil) {
        self.name = name
        self.contactNumber = contactNumber
        self.alternateContactNumber = alternateContactNumber
        self.email = email
        self.address = address
        self.laungageKnown = laungageKnown?.rawValue
        self.doj = doj
        self.status = status?.rawValue
    }
}

enum LaungageKnown: String {
    case tamil = "Tamil"
    case hindi = "Hindi"
    case malayalam = "Malayalam"
    case telugu = "Telugu"
}

enum EmployeeStatus: String {
    case active = "Active"
    case inactive = "Inactive"
    case contract = "Contract"
}
