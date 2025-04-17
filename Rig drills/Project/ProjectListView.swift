//
//  Project.swift
//  Rig drills
//
//  Created by Dinesh on 02/04/25.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var projects: [Project]
    @State private var isNavigating = false
    @State private var accessToken: String = ""

//    init() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.lightGray // Set navigation bar color
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Title text color
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    ForEach(projects) { item in
                        NavigationLink {
                            ProjectDetailView(project: item)
                        } label: {
                            Text(item.name)
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
                ProjectDetailView()
            }
            .navigationTitle("Projects")
        }
    }

    
    private func addItem() {
        isNavigating = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(projects[index])
            }
        }
    }
}
