//
//  RankingView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 24.02.2023.
//

import SwiftUI
import CoreData

struct RankingView: View {

    @StateObject private var vm: SearchViewModel = SearchViewModel()
    
//    @FetchRequest(entity: ContentDetailsEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ContentDetailsEntity.title, ascending: true)]) var fetchResults: FetchedResults<ContentDetailsEntity>

    
    // MARK: BODY
    var body: some View {
        ZStack {
            // BACKGROUND
            Color.black.edgesIgnoringSafeArea(.all)
            
            // FOREGROUND
            VStack {
                if vm.savedContent.isEmpty {
                    VStack {
                        Image(systemName: "trophy")
                            .font(.largeTitle)
                        Text("Select your favourite content and we will display it right here for ya!")
                            .font(.system(.title, design: .rounded, weight: .light))
                            .padding(20)
                            .multilineTextAlignment(.center)
                            .kerning(4)
                            .lineSpacing(10)
                    }
                } else {
                    List {
                        Section {
                            customRow
                        } header: {
                            Text("My Favourites are:")
                        }
                        .headerProminence(.increased)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                    .padding(.horizontal)
                }
            }
            .foregroundColor(Color.white)
            .onAppear {
                vm.fetchFromCoreData()
            }
        }
             
    }
}
struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
        
    }
}

// MARK: COMPONENTS
extension RankingView {
    
    private var customRow: some View {
        ForEach(vm.savedContent) { content in
            Text(content.title ?? "no valuee")
                .foregroundColor(Color.white)
        }
        .onDelete(perform: vm.deleteFromCoreData)
        .onMove(perform: vm.reorderCoreData)
        .listRowBackground(Color.gray.opacity(0.3))
        
        
    }
    
    
    
}
