//
//  RankingView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 24.02.2023.
//

import SwiftUI

struct RankingView: View {
    
    @StateObject var vm: RankingViewModel = RankingViewModel()
    
    
    var body: some View {
        ZStack {
            
            // BACKGROUND
            Color.black.edgesIgnoringSafeArea(.all)
            
            // FOREGROUND
            VStack {
                TextField("", text: $vm.searchedText, prompt: Text("Search for a movie...")
                    .foregroundColor(Color.white))
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 40)
                    .frame(height: 40)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .autocorrectionDisabled(true)
                    .onChange(of: vm.searchedText) { newValue in
                        vm.dataService.downloadData(searchedText: vm.searchedText)
                        vm.addSubscribers()
                    }
                
                List {
                    Section {
                        customRow
                    } header: {
                        Text("My Favourite Series:")
                            .foregroundColor(Color.white)
                    }
                    .headerProminence(.increased)

                    

                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                .padding(.horizontal)
            }
            
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
            
    }
}
extension RankingView {
    
    private var customRow: some View {
        ForEach(vm.MovieCatalog) { movie in
                HStack {
                    Text(movie.title ?? "no value")
                        .foregroundColor(Color.white)
                    
                }
        }
        .listRowBackground(Color.gray.opacity(0.3))
    }
    
    
    
}
