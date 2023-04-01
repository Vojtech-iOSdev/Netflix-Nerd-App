//
//  RankingView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 24.02.2023.
//

import SwiftUI

struct RankingView: View {
    // MARK: PROPERTIES
    @StateObject private var vm: SearchViewModel = SearchViewModel()
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // BACKGROUND
            Color.black.edgesIgnoringSafeArea(.all)
            
            // FOREGROUND
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
// MARK: PREVIEW
struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
        
    }
}

// MARK: COMPONENTS
extension RankingView {
    
    private var customRow: some View {
        ForEach(vm.MovieCatalog) { movie in
            Text(movie.title ?? "no value")
                .foregroundColor(Color.white)
              
        }
        .listRowBackground(Color.gray.opacity(0.3))
    }
    
    
    
}
