//
//  Item.swift
//  Rig drills
//
//  Created by Dinesh on 01/04/25.
//

import Foundation
import SwiftData



@Model
class Project {
    var name: String
    var customer: Customer?
    var edd: Date?
    var estimatedCost: Double?
    var status: String
    var createdAt: Date
    var updatedAt: Date
    var notes: String?
    var projectManager: Employee?
    
    init(name: String, customer: Customer?, edd: Date, estimatedCost: Double? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), notes: String? = nil, projectManager: Employee? = nil, status: ProjectStatus = .inEnquiry) {
        self.name = name
        self.customer = customer
        self.edd = edd
        self.estimatedCost = estimatedCost
        self.status = status.rawValue
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.notes = notes
        self.projectManager = projectManager
    }
}

enum ProjectStatus: String {
    case inEnquiry = "In Enquiry"
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case completed = "Completed"
    case onHold = "On Hold"
    case cancelled = "Cancelled"
}
