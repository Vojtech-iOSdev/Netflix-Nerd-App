//
//  SeriesDetailView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 22.02.2023.
//

import SwiftUI

struct SeriesDetailView: View {
    // MARK: PROPERTIES
    @StateObject var vmRanking: RankingViewModel = RankingViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: .center),
        GridItem(.flexible(), spacing: 10, alignment: .center),
        GridItem(.flexible(), spacing: 10, alignment: .center)
    ]
    
    let selectedSeries: Series
    
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
        
    }
}

// MARK: PREVIEW
struct SeriesDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        SeriesDetailView(selectedSeries: CatalogOfContent.tvShows[0])
            
    }
}

// MARK: COMPONENTS
extension SeriesDetailView {
    
    private var imageOfSeries: some View {
        Image(selectedSeries.image)
            .resizable()
            .frame(width: 320, height: 300)
            .cornerRadius(10)
            .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 4)
        
    }
    
    private var title: some View {
        Text(selectedSeries.title)
            .foregroundColor(Color.white)
            .font(.system(.largeTitle, design: .rounded, weight: .semibold))
        
    }
    
    private var releaseDate_Rating_IsFavourite: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Release:    \(selectedSeries.releasseDate)")
                    .foregroundColor(Color.white)
                .font(.system(.subheadline , design: .rounded, weight: .medium))
                
                Text("Rating:        \(selectedSeries.rating, specifier: "%.1f")/10")
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
            Text(selectedSeries.description)
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
            
            HStack(alignment: .center) {
                ForEach(selectedSeries.mainActors, id: \.self) { actor in
                    Text(actor)
                        .foregroundColor(Color.white)
                        .font(.system(.caption, design: .rounded, weight: .light))
                    
                }
            }
        }
        
    }
    
    private var moreSeriesInVGrid: some View {
        VStack {
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 10) {
                ForEach(CatalogOfContent.tvShows.shuffled()) { series in
                    NavigationLink(destination: SeriesDetailView(selectedSeries: series)) {
                        Image(series.image)
                            .resizable()
                            .frame(width: 110, height: 180)
                            .scaledToFit()
                    }
                    
                }
            }
            
        }
        
    }
    
}
