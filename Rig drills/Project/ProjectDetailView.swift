//
//  ProjectDetailView.swift
//  Rig drills
//
//  Created by Dinesh on 03/04/25.
//

import SwiftUI
import Contacts

struct ProjectDetailView: View {
    @State private var name = ""
    @State private var customer: Customer?
    @State private var edd = Date()
    @State private var estimatedCost = 0.0
    @State private var status: ProjectStatus = .inEnquiry
    @State private var createdAt = Date()
    @State private var updatedAt = Date()
    @State private var notes = ""
    @State private var projectManager: Employee?
    @State private var selectedCustomer: Customer? = nil
    @State private var isCustomerListPresented: Bool = false
    @State private var showDatePicker = false
    enum DateField: Hashable {
        case estimatedDelivery, confirmationDate, pickupDate
    }
    
    @State private var dates: [DateField: Date] = [
        .estimatedDelivery: Date(),
        .confirmationDate: Date(),
        .pickupDate: Date()
    ]
    @State private var selectedField: DateField?
    @State private var tempDate = Date()
    
    var project: Project?
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let contactStore = CNContactStore()
    
    var isFormValid: Bool {
        return validateName(name) &&
        customer != nil &&
        edd != Date() &&
        !notes.isEmpty
    }
    
    @State private var showContactPicker = false
    var customerBinding: Binding<String> {
        Binding(
            get: { selectedCustomer?.name ?? "" },
            set: { selectedCustomer?.name = $0 }
        )
    }
    
    var body: some View {      
        
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Project Information")) {
                        CustomTextField(label: "Title", placeholder: "Enter title", text: $name, isValid: validateName(name))
                        CustomTextField(label: "Customer", placeholder: "Select customer", text: customerBinding, isValid: true)
                            .disabled(true)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                isCustomerListPresented = true
                            }
                        CustomDatePickerField(
                            label: "Estimated Delivery Date",
                            placeholder: "Select date",
                            date: dates[.estimatedDelivery]
                        ) {
                            presentPicker(for: .estimatedDelivery)
                        }
                        
                        CustomDatePickerField(
                            label: "created Date",
                            placeholder: "Select date",
                            date: dates[.confirmationDate]
                        ) {
                            presentPicker(for: .confirmationDate)
                        }
                        
                        CustomDatePickerField(
                            label: "Last Update Date",
                            placeholder: "Select date",
                            date: dates[.pickupDate]
                        ) {
                            presentPicker(for: .pickupDate)
                        }
                    }
                    Section {
                        Button(action: handleSubmit) {
                            Text("Submit")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .padding()
                                .background(isFormValid ? Color.blue : Color.gray)
                                .cornerRadius(8)
                        }
                        .disabled(!isFormValid)
                    }
                }
                .navigationTitle("Project Details")
                .customDatePickerOverlay(
                    isPresented: $showDatePicker,
                    selectedDate: $tempDate,
                    selectedField: selectedField
                ) { field, newDate in
                    dates[field] = newDate
                }
                .sheet(isPresented: $isCustomerListPresented) {
                    CustomerListView(selectedCustomer: $selectedCustomer)
                }
            }
        }
    }
    
    func handleSubmit() {
        if let project {
            project.name = name
            project.customer = customer
            project.edd = edd
            project.estimatedCost = estimatedCost
//            project.status = status
            project.createdAt = createdAt
            project.updatedAt = updatedAt
            project.notes = notes
            project.projectManager = projectManager
            try? modelContext.save()
                                        
        } else  {
            modelContext.insert(Project(name: name, customer: customer, edd: edd, estimatedCost: estimatedCost, createdAt: createdAt, updatedAt: updatedAt, notes: notes, projectManager: projectManager))
        }
        
        // Clear the fields
        clearFields()
        // Dismiss the view
        dismiss()
    }
    
    func clearFields() {
        name = ""
    }
    
    // Validation Functions
    func validateName(_ name: String) -> Bool {
        return name.count >= 2
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validatePhone(_ phone: String) -> Bool {
        //        let phoneRegex = "^[6-9]\\d{9}$" // Indian number starting with 6-9 and 10 digits
        let phoneRegex = #"^\+?[1-9][0-9\s\-\(\)]{6,14}[0-9]$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phone)
    }
}


extension ProjectDetailView {
    init(project: Project) {
        _name = State(initialValue: project.name)
        _customer = State(initialValue: project.customer)
        _edd = State(initialValue: project.edd ?? Date())
        _estimatedCost = State(initialValue: project.estimatedCost ?? 0.0)
        //        _status = State(initialValue: project.status)
        _createdAt = State(initialValue: project.createdAt)
        _updatedAt = State(initialValue: project.updatedAt)
        _notes = State(initialValue: project.notes ?? "")
        _projectManager = State(initialValue: project.projectManager)
    }
    
    func presentPicker(for field: DateField) {
        selectedField = field
        tempDate = dates[field] ?? Date()
        withAnimation {
            showDatePicker = true
        }
    }
}
