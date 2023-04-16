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
    @Environment(\.currentTab) var tab
    
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
                            addButton
                        } header: {
                            Text("My List of Favourites 🥰")
                        }
                        .headerProminence(.increased)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
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
private extension RankingView {
    
    var customRow: some View {
        ForEach(vm.savedContent) { content in
            HStack {
                Image(systemName: "trophy.fill")
                    // change based of indices
                    .foregroundColor(Color(content == vm.savedContent.first ? .systemYellow :
                                            content == vm.savedContent[1] ? .systemGray :
                                            content == vm.savedContent[2] ? .systemBrown : .clear))
                
                AsyncImage(url: URL(string: content.poster ?? vm.randomUrl)) { returnedImage in
                    switch returnedImage {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    case .failure(_):
                        Image(systemName: "questionmark.app.dashed")
                            .font(.largeTitle)
                    default:
                        Image(systemName: "questionmark.app.dashed")
                            .font(.largeTitle)
                    }
                }
                .frame(width: 100, height: 100)

                VStack(alignment: .leading) {
                    Text(content.title ?? "error loading content")
                        .font(.system(.headline, design: .rounded, weight: .medium))
                    Text(content.year ?? "No value")
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                    Text(content.type ?? "No value")
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                    
                }
            }
            .foregroundColor(Color.white)
            
        }
        .onDelete(perform: vm.deleteFromCoreData)
        .onMove(perform: vm.reorderCoreData)
        .listRowBackground(Color.gray.opacity(0.3))
        .listRowSeparator(.hidden)
        .padding(0)
    }
    
    var addButton: some View {
        Button {
            tab.wrappedValue = .homeView
        } label: {
            Label("Add", systemImage: "plus")
                .bold()
        }
        .frame(height: 70)
        .padding(.horizontal, 100)
        .listRowBackground(Color.gray.opacity(0.3))
    }
}
