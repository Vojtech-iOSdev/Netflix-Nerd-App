//
//  MovieDetailView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 20.03.2023.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var vm: SearchViewModel = SearchViewModel()
    @StateObject private var vmRanking: RankingViewModel = RankingViewModel()
    
    let movieSelected: MovieModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 110), spacing: 10, alignment: .center),
        GridItem(.flexible(), spacing: 10, alignment: .center),
        GridItem(.flexible(), spacing: 10, alignment: .center)
    ]
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // BACKGROUND
            Color.black.edgesIgnoringSafeArea(.all)
            
            //FOREGROUND
            ScrollView {
                VStack(spacing: 10) {
                    imageOfSeries
                    title
                    
                    VStack(alignment: .leading, spacing: 3) {
                        releaseDate_Rating_IsFavourite
                        Spacer()
                        description
                        Spacer()
                        seriesMainActors
                        Spacer()
                        moreSeriesInVGrid
                    }.padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
        }
        .task {
            vm.getMovieID(movieID: movieSelected.id)
            vm.sinkToSelectedMovieDetails()
            vm.sinkToSelectionForParanormal()
            vm.sinkToSelectionForSpiderman()
            vm.sinkToSelectionForTOP10()
            vm.sinkToSelectionForLOTR()
            vm.sinkToSelectionForBatman()
        }
        
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieSelected: MovieModel(title: "Hello America, i am right here!", year: "2022", imdbID: "IDK", type: .movie, poster: "URL for a movie"))
    }
}

// MARK: COMPONENTS
extension MovieDetailView {
    
    private var imageOfSeries: some View {
        AsyncImage(url: URL(string: vm.selectedContentDetails.poster ?? vm.randomUrl)) { returnedImage in
                switch returnedImage {
                case .empty:
                    ProgressView()
                case .success (let image):
                    image
                        .resizable()
                        .frame(width: 320, height: 300)
                        .cornerRadius(10)
                        .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 4)
                case .failure (_):
                    Image(systemName: "questionmark.app.dashed")
                default:
                    Image(systemName: "questionmark.app.dashed")
                }
        }
        .frame(width: 320, height: 300)
    }
    
    private var title: some View {
        Text(vm.selectedContentDetails.title ?? "no title")
            .foregroundColor(Color.white)
            .font(.system(.largeTitle, design: .rounded, weight: .semibold))
        
    }
    
    private var releaseDate_Rating_IsFavourite: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Release:    \(vm.selectedContentDetails.released ?? "NA")")
                    .foregroundColor(Color.white)
                    .font(.system(.subheadline , design: .rounded, weight: .medium))
                
                Text("Rating:        \(vm.selectedContentDetails.rating ?? "NA") /10")
                    .foregroundColor(Color.white)
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
            }
            Spacer()
            
            Image(systemName: vmRanking.isFavourite == true ? "heart.fill" : "heart")
                .foregroundColor(vmRanking.isFavourite == true ? Color.red : Color.white)
                .tint(Color.white)
            //                                .onTapGesture {
            //                                     selectedSeries.isFavourite.toggle()
            //                                }
        }.padding(.trailing, 20)
        
    }
    
    private var description: some View {
        VStack {
            Text(vm.selectedContentDetails.description ?? "NA")
                .foregroundColor(Color.white)
                .font(.system(.caption, design: .rounded, weight: .regular))
                .multilineTextAlignment(.leading)
        }
        
    }
    
    private var seriesMainActors: some View {
        VStack(alignment: .leading) {
            Text("Main actors:")
                .foregroundColor(Color.white)
                .font(.system(.subheadline , design: .rounded, weight: .medium))
            
            Text(vm.selectedContentDetails.actors ?? "NA")
                .foregroundColor(Color.white)
                .font(.system(.caption, design: .rounded, weight: .light))
        }
    }
    
    private var moreSeriesInVGrid: some View {
        VStack {
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 10) {
                ForEach(vm.selectionForTOP10) { selection in
                    NavigationLink(destination: MovieDetailView(movieSelected: selection)) {
                        AsyncImage(url: URL(string: selection.poster ?? vm.randomUrl)) { returnedImage in
                            switch returnedImage {
                            case .empty:
                                ProgressView()
                            case .success (let image):
                                image
                                    .resizable()
                                    .frame(width: 110)
                                    .frame(idealHeight: 180)
                                    .scaledToFit()
                            case .failure (_):
                                Image(systemName: "questionmark.app.dashed")
                            default:
                                Image(systemName: "questionmark.app.dashed")
                            }
                        }
                        .frame(width: 110, height: 180)
                    }
                    
                }
            }
            
        }
        
    }
    
}

