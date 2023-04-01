//
//  TabBarView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.02.2023.
//

import SwiftUI

struct TabBarView: View {
    // MARK: PROPERTIES
    @StateObject var vm: OnboardingViewModel = OnboardingViewModel()
    
    @State var selectedTab: Int = 0
    
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
   
    // MARK: BODY
    var body: some View {
        
        if vm.isSigned {
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
                .toolbarBackground(Color.black, for: .tabBar)
            }
            .transition(transition)

        }else {
            OnboardingView()
                .transition(transition)
        }
    }
}


// MARK: PREVIEW
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


