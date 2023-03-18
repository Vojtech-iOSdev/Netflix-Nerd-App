//
//  HomeView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 21.02.2023.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: PROPERTIES
    let genres: [String] = ["Drama:", "Action:", "Netflix TOP10 in the US:", "Comedy:", "Horror:"]
    
    
    // MARK: BODY
    var body: some View {
        NavigationView {
            ZStack {
                // BACKGROUND
                Color.black.edgesIgnoringSafeArea(.all)
                
                // FOREGROUND
                VStack(spacing: 0) {
                    //Spacer()
                    NetflixLogoView
                    SeriesCatalogWithScrollViews
                    //Spacer()
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
    }
    
    private var SeriesCatalogWithScrollViews: some View {
        VStack {
            // COLUMNS
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(genres, id: \.self) { genre in
                        // ROWS
                        if genre == genres[2] {
                            top10SeriesElement(genre: genre)
                        }else{
                            VStack(alignment: .leading, spacing: 1) {
                                // SECTIONS
                                Section(header: Text(genre)
                                    .foregroundColor(Color.white)
                                    .font(.system(.title2, design: .rounded, weight: .bold))
                                    .padding(.leading, 0)
                                ) {
                                    // SERIES ELEMENTS
                                    seriesElement
                                }
                            }
                        }
                        
                    }
                }
            }
        }.padding(.horizontal)
    }
    
    private var seriesElement: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 0) {
                ForEach(CatalogOfContent.tvShows.shuffled()) { series in
                    NavigationLink(destination: SeriesDetailView(selectedSeries: series)) {
                        VStack(alignment: .leading, spacing: 12) {
                            Image(series.image)
                                .resizable()
                                .frame(width: 200, height: 120, alignment: .leading)
                                .background(Color.red)
                                .scaledToFill()
                                .cornerRadius(10)
                                .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
                            
                            
                            Text(series.title)
                                .foregroundColor(Color.white)
                                .font(.system(.headline, design: .rounded, weight: .medium))
                                .padding(.leading, 12)
                            
                        }
                        
                    }.padding(5)
                }.accentColor(Color.white)
                
            }
        }
    }
    
    func top10SeriesElement(genre: String) -> some View {
        VStack(alignment: .leading, spacing: 1) {
            // sections
            Section(header: Text(genre)
                .foregroundColor(Color.white)
                .font(.system(.title2, design: .rounded, weight: .bold))
                .padding(.leading, 0)
            ) {
                // top10SeriesElement with NavigationLink
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 0) {
                        ForEach(CatalogOfContent.tvShows.shuffled()) { series in
                            NavigationLink(destination: SeriesDetailView(selectedSeries: series)) {
                                VStack(alignment: .center, spacing: 12) {
                                    Image(series.image)
                                        .resizable()
                                        .frame(width: 200, height: 300, alignment: .leading)
                                        .background(Color.red)
                                        .scaledToFill()
                                        .shadow(color: Color.white.opacity(0.2), radius: 8, x: 0, y: 0)
                                    
                                    Text(series.title)
                                        .foregroundColor(Color.white)
                                        .font(.system(.headline, design: .rounded, weight: .regular))
                                        .padding(.leading, 12)
                                    
                                }.padding(10)
                            }
                        }
                    }
                }
            }
        }.padding(.vertical, 20)
    }
    
}

// MARK: FUNCIONS

