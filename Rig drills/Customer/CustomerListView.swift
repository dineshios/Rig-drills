//
//  ContentView.swift
//  D3p
//
//  Created by Dinesh on 26/03/25.
//

import SwiftUI
import SwiftData

struct CustomerListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var customers: [Customer]
    @State private var isNavigating = false
    @State private var accessToken: String = ""
    @State var isPresented: Bool = false
    var selectedCustomer: Binding<Customer?>?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    ForEach(customers) { item in
                        if let binding = selectedCustomer {
                            Button {
                                binding.wrappedValue = item
                                dismiss()
                            } label: {
                                Text(item.name)
                            }
                        } else {
                            NavigationLink {
                                CustomerDetailView(customer: item)
                            } label: {
                                Text(item.name)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isNavigating) {
                CustomerDetailView()
            }
            .navigationTitle("Customers")
        }
    }

//    func addContactToGoogle(accessToken: String) {
//        let url = URL(string: "https://people.googleapis.com/v1/people:createContact")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let contactData: [String: Any] = [
//            "names": [["givenName": "John", "familyName": "Doe"]],
//            "emailAddresses": [["value": "john.doe@example.com"]],
//            "phoneNumbers": [["value": "+1234567890"]]
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: contactData)
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error adding contact: \(error.localizedDescription)")
//                return
//            }
//            print("Contact added successfully!")
//        }.resume()
//    }
    
    private func addItem() {
        isNavigating = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(customers[index])
            }
        }
    }
}

//#Preview {
//    CustomerListView(isPresented: <#Binding<Bool>#>, selectedItem: <#Binding<Customer>#>)
//        .modelContainer(for: Customer.self, inMemory: true)
//}

