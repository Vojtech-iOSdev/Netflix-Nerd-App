//
//  HomeView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 21.02.2023.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: PROPERTIES
    @StateObject private var vm: SearchViewModel = SearchViewModel()
    
    
    // MARK: BODY
    var body: some View {
        NavigationStack {
            ZStack {
                // BACKGROUND
                Color.black.edgesIgnoringSafeArea(.all)
                
                // FOREGROUND
                VStack(spacing: 0) {
                    NetflixLogoAndProfilePic
                    SearchField
                    if vm.searchedText.isEmpty {
                        HomeContentRowsView()
                    }
                }
                .onAppear {
                    vm.getProfilePicture()
                }
            }
        }
        
    }
}

// MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// MARK: COMPONENTS
extension HomeView {
    
    private var NetflixLogoAndProfilePic: some View {
        HStack {
            Image("Netflix")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 120)
                .padding(0)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    if vm.profilePicture == nil {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.gray.opacity(0.4))
                    } else {
                        Image(uiImage: vm.profilePicture!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipped()
                            .cornerRadius(30)
                            .shadow(color: .white, radius: 4, x: 0, y: 0)
                    }
                }
                .padding(20)
                .onTapGesture {
                    vm.selectedTab = 2
                }
        }
    }
    
    private var SearchField: some View {
        VStack(spacing: 0) {
            TextField("", text: $vm.searchedText, prompt: Text("Search more content...")
                .foregroundColor(Color.white))
            .font(.system(.title3, design: .rounded, weight: .semibold))
            .foregroundColor(Color.white)
            .padding(.horizontal, 30)
            .frame(height: 40)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .padding(.bottom)
            .padding(.horizontal, 6)
            .autocorrectionDisabled(true)
            .onChange(of: vm.searchedText) { newValue in
                vm.sinkTosearchResults()
            }
            
            if !vm.searchedText.isEmpty {
                withAnimation(.easeInOut) {
                    List {
                        ForEach(vm.searchResults) { movie in
                            SearchListRowView(contentSearched: movie, randomUrl: vm.randomUrl)
                            
                        }
                        .listRowBackground(Color.gray.opacity(0.3))
                        .listStyle(.plain)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            
        }
    }
    
    
}



