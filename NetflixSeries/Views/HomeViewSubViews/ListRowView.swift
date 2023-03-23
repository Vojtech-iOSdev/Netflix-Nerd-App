//
//  ListRowView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 20.03.2023.
//

import SwiftUI

struct ListRowView: View {
    
    let movieSelected: MovieModel
    let randomUrl: String = "https://media.istockphoto.com/id/525982128/cs/fotografie/agresivita-koček.jpg?s=1024x1024&w=is&k=20&c=y632ynYYyc3wS5FuPBgnyXeBNBC7JmjQNwz5Vl_PvI8="
    
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
                            .padding(.horizontal, 30)
                    default:
                        Image(systemName: "questionmark.app.dashed")
                            .font(.largeTitle)
                            .padding(.horizontal, 30)
                    }
                }
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

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(movieSelected: MovieModel(title: "Hello America, i am right here!", year: "2022", imdbID: "IDK", type: .movie, poster: "URL for a movie"))
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
