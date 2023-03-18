//
//  TabBarView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.02.2023.
//

import SwiftUI

struct TabBarView: View {
    // MARK: PROPERTIES
    @StateObject var vm: SeriesViewModel = SeriesViewModel()
    
    @State var selectedTab: Int = 0
    
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    // APP STORAGE
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("nationality") var currentUserNationality: String?
    @AppStorage("isSigned") var isSigned: Bool = false
    
    
    // MARK: BODY
    var body: some View {
        
        if isSigned {
            TabView(selection: $selectedTab) {
                Group {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("home")
                        }
                        .tag(0)

                    
                    
                    RankingView()
                        .tabItem {
                            Image(systemName: "trophy.fill")
                            Text("ranking")
                        }
                        .tag(1)
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("profile")
                        }
                        .tag(2)
                }
                .environmentObject(SeriesViewModel())
                .toolbarBackground(Color.black, for: .tabBar)

                
            }
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

        }else {
            OnboardingView()
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
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
            .environmentObject(SeriesViewModel())
    }
}

// MARK: COMPONENTS
extension TabBarView {
    private var TabBar: some View {
        Text("hi")
    }
    
}
