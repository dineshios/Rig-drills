//
//  EmployeeDetailView.swift
//  Rig drills
//
//  Created by Dinesh on 03/04/25.
//

import SwiftUI
import Contacts
struct EmployeeDetailView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var alternatePhone = ""
    @State private var laungageKnown = ""
    var customer: Customer?
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let contactStore = CNContactStore()
    
    var isFormValid: Bool {
        return validateName(name) &&
               validateEmail(email) &&
               validatePhone(phone) &&
               !address.isEmpty
    }
    
    @State private var showContactPicker = false
    @State private var selectedContact: String = "No contact selected"
    
    
    var body: some View {
        
        NavigationView {
            Form {
                VStack {
                    Button("Pick a Contact") {
                        showContactPicker = true
                    }
                    .sheet(isPresented: $showContactPicker) {
                        ContactPickerView { contact in
                            name = contact.givenName
                            email = contact.emailAddresses.first?.value as? String ?? ""
                            phone = contact.phoneNumbers.first?.value.stringValue ?? ""
                            address = contact.postalAddresses.first?.value.street ?? ""
                        }
                    }
                }
                Section(header: Text("Personal Information")) {
                    CustomTextField(label: "Name", placeholder: "Enter name", text: $name, isValid: validateName(name))
                    CustomTextField(label: "Email", placeholder: "Enter email", text: $email, keyboardType: .emailAddress, isValid: validateEmail(email))
                    CustomTextField(label: "Phone", placeholder: "Enter phone", text: $phone, keyboardType: .phonePad, isValid: validatePhone(phone))
                    CustomTextEditor(label: "Address", placeholder: "Enter address", text: $address, isValid: !address.isEmpty)
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
            .navigationTitle("Customer Details")
        }
    }
    
    func handleSubmit() {
        if let customer {
            customer.name = name
            customer.email = email
            customer.contactNumber = phone
            customer.address = address
            try? modelContext.save()
                                        
        } else  {
            modelContext.insert(Customer(name: name, contactNumber: phone, alternateContactNumber: "0987654321", email: email, country: "India", address: address))
            saveContact(firstName: name, lastName: "", phoneNumber: phone, email: email)
        }
        
        // Clear the fields
        clearFields()
        // Dismiss the view
        dismiss()
    }
    
    func clearFields() {
        name = ""
        email = ""
        phone = ""
        address = ""
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


extension EmployeeDetailView {
    init(customer: Customer) {
        self.customer = customer
        _name = State(initialValue: customer.name)
        _email = State(initialValue: customer.email ?? "")
        _phone = State(initialValue: customer.contactNumber)
        _address = State(initialValue: customer.address ?? "")
    }
    
    func saveContact(firstName: String, lastName: String, phoneNumber: String, email: String) {
        
        // Create a new contact
        let contact = CNMutableContact()
        contact.givenName = firstName
        contact.familyName = lastName
        
        // Add phone number
        let phoneValue = CNPhoneNumber(stringValue: phoneNumber)
        let phone = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: phoneValue)
        contact.phoneNumbers = [phone]
        
        // Add email
        let emailValue = CNLabeledValue(label: CNLabelWork, value: email as NSString)
        contact.emailAddresses = [emailValue]
        
        // Save to contacts
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        
        do {
            try contactStore.execute(saveRequest)
            print("Contact saved successfully!")
        } catch {
            print("Failed to save contact: \(error)")
        }
    }
}
