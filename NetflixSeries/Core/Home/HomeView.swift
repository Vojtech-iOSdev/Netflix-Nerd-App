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
        NavigationView {
            ZStack {
                // BACKGROUND
                Color.black.edgesIgnoringSafeArea(.all)
                
                // FOREGROUND
                VStack(spacing: 0) {
                    NetflixLogoView
                    SearchField
                    if vm.searchedText.isEmpty {
                        SelectionRowsView()
                    }
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
    
    private var NetflixLogoView: some View {
        Image("Netflix")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .padding(0)
            .background{ Color.green }
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
                vm.dataService.fetchData(searchedText: vm.searchedText)
                vm.sinkToMovieCatalog()
            }
            
            if !vm.searchedText.isEmpty {
                withAnimation(.easeInOut) {
                    List {
                        ForEach(vm.movieCatalog) { movie in
                            SearchListRowView(movieSelected: movie, randomUrl: vm.randomUrl)
                            
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



