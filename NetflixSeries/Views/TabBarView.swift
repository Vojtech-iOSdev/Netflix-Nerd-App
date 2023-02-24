//
//  TabBarView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.02.2023.
//

import SwiftUI

struct TabBarView: View {
    // MARK: PROPERTIES
    @State var selectedTab: Int = 0
    
    // APP STORAGE
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("nationality") var currentUserNationality: String?
    @AppStorage("isSigned") var isSigned: Bool = true
    
    // MARK: BODY
    var body: some View {
        
        if isSigned {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("home")
                    }.tag(0)
                
                RankingView()
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text("ranking")
                    }.tag(1)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("profile")
                    }.tag(2)
            }
            .toolbarBackground(Color.black, for: .tabBar)
            
            
        }else {
            OnboardingView()
        }

    }
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        currentUserNationality = nil
        isSigned = false
    }
}


// MARK: PREVIEW
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

// MARK: COMPONENTS
extension TabBarView {
    private var TabBar: some View {
        Text("hi")
    }
    
}
