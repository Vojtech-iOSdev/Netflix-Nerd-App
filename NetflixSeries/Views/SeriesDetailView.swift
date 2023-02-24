//
//  SeriesDetailView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 22.02.2023.
//

import SwiftUI

struct SeriesDetailView: View {
    // MARK: PROPERTIES
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: .center),
        GridItem(.flexible(), spacing: 10, alignment: .center),
        GridItem(.flexible(), spacing: 10, alignment: .center)
    ]
    
    var selectedSeries: Series
    
    // MARK: BODY
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 10) {
                    
                    Image(selectedSeries.image)
                        .resizable()
                        .frame(width: 320, height: 300)
                        .cornerRadius(10)
                        .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 4)
                    
                    Text(selectedSeries.title)
                        .foregroundColor(Color.white)
                        .font(.system(.largeTitle, design: .rounded, weight: .semibold))
                    
                    VStack(alignment: .leading, spacing: 3) {
                        
                        
                        
                        Text("Release:    \(selectedSeries.releasseDate)")
                            .foregroundColor(Color.white)
                            .font(.system(.subheadline , design: .rounded, weight: .medium))
                        
                        
                        
                        Text("Rating:        \(selectedSeries.rating, specifier: "%.1f")/10")
                            .foregroundColor(Color.white)
                            .font(.system(.subheadline, design: .rounded, weight: .medium))
                        Spacer()
                        
                        VStack {
                            Text(selectedSeries.description)
                                .foregroundColor(Color.white)
                                .font(.system(.caption, design: .rounded, weight: .regular))
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                        
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
                        Spacer()
                        
                        
                        VStack {
                            LazyVGrid(columns: columns,
                                      alignment: .center,
                                      spacing: 10) {
                                ForEach(TVShows.shuffled()) { series in
                                    NavigationLink(destination: SeriesDetailView(selectedSeries: series)) {
                                        Image(series.image)
                                            .resizable()
                                            .frame(width: 110, height: 180)
                                            .scaledToFit()
                                    }
                                    
                                }
                            }
                            
                        }
                        
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
        SeriesDetailView(selectedSeries: TVShows[0])
    }
}
