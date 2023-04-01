//
//  ListSearchRowView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 20.03.2023.
//

import SwiftUI

struct SearchListRowView: View {
    
    let movieSelected: MovieModel
    let randomUrl: String
    
    // MARK: BODY
    var body: some View {
        NavigationLink {
            MovieDetailView(movieSelected: movieSelected)
        } label: {
            HStack {
                AsyncImage(url: URL(string: movieSelected.poster ?? randomUrl)) { returnedImage in
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
                    Text(movieSelected.title ?? "No value")
                        .font(.system(.headline, design: .rounded, weight: .medium))
                    Text(movieSelected.year ?? "No value")
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                    Text(movieSelected.type?.rawValue ?? "No value")
                        .font(.system(.subheadline, design: .rounded, weight: .light))
                    
                }
            }
        }.foregroundColor(Color.white)
        
    }
}

struct SearchListRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListRowView(movieSelected: MovieModel.dummyData[0], randomUrl: "www.apple.com")
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
