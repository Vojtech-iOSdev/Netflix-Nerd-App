//
//  TabBarView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.02.2023.
//

import SwiftUI

struct TabBarView: View {

    @StateObject var onboardingVM: OnboardingViewModel = OnboardingViewModel()
    @StateObject var vm: SearchViewModel = .init()
        
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        
        if onboardingVM.isSigned {
            TabView(selection: $vm.selectedTab) {
                Group {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("home")
                        }
                        .tag(SearchViewModel.Tab.homeView)
                        .environment((\.currentTab), $vm.selectedTab)
                    
                    RankingView()
                        .tabItem {
                            Image(systemName: "trophy.fill")
                            Text("ranking")
                        }
                        .tag(SearchViewModel.Tab.rankingView)
                        .environment((\.currentTab), $vm.selectedTab)
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("profile")
                        }
                        .tag(SearchViewModel.Tab.profileView)
                        .environment((\.currentTab), $vm.selectedTab)

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

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
