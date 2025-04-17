//
//  MainTabbedView.swift
//  Rig drills
//
//  Created by Dinesh on 02/04/25.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case projects = 0
    case customers
    case employee
    case profile
    
    var title: String{
        switch self {
        case .projects:
            return "Projects"
        case .customers:
            return "Customers"
        case .employee:
            return "Employees"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .projects:
            return "home-icon"
        case .customers:
            return "favorite-icon"
        case .employee:
            return "chat-icon"
        case .profile:
            return "profile-icon"
        }
    }
}

struct MainTabbedView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                ProjectListView()
                    .tag(0)
                
                CustomerListView(selectedCustomer: nil)
                    .tag(1)

                ProjectListView()
                    .tag(2)

                SettingsView()
                    .tag(3)
            }

            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
            }
            .frame(height: 80)
            .background(.blue.opacity(0.4))
            .cornerRadius(40)
            .padding(.horizontal, 26)
        }
    }
}

extension MainTabbedView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        VStack(spacing: 10){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
            Spacer()
        }
        .frame(width: 80 , height: 80)
        .background(isActive ? .blue.opacity(0.6) : .clear)
        .cornerRadius(40)
    }
}
