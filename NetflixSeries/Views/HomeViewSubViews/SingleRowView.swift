//
//  SingleRowView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 24.03.2023.
//

import SwiftUI

struct SingleRowView: View {
    
    @StateObject private var vm: SearchViewModel = SearchViewModel()
    let genre: String
    let selectionCatalog: [MovieModel]
    let randomUrl: String = "https://media.istockphoto.com/id/525982128/cs/fotografie/agresivita-koček.jpg?s=1024x1024&w=is&k=20&c=y632ynYYyc3wS5FuPBgnyXeBNBC7JmjQNwz5Vl_PvI8="
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            // SECTIONS
            Section(header: Text(genre)
                .foregroundColor(Color.white)
                .font(.system(.title2, design: .rounded, weight: .bold))
                .padding(.leading, 0)
            ) {
                // SERIES ELEMENTS
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 0) {
                        ForEach(selectionCatalog) { selection in
                            NavigationLink(destination: MovieDetailView(movieSelected: selection)) {
                                VStack(alignment: .leading, spacing: 12) {
                                    AsyncImage(url: URL(string: selection.poster ?? randomUrl)) { returnedImage in
                                        switch returnedImage {
                                        case .empty:
                                            ProgressView()
                                        case .success (let image):
                                            image
                                                .resizable()
                                                .frame(width: 200,
                                                       height: genre == vm.genres[2] ? 280 :  120,
                                                       alignment: .leading)
                                                .background(Color.red)
                                                .scaledToFill()
                                                .cornerRadius(10)
                                                .shadow(color: Color.white.opacity(0.2), radius: 5, x: 0, y: 5)
                                        case .failure (_):
                                            Image(systemName: "xmark")
                                        default:
                                            Image(systemName: "xmark")
                                        }
                                    }
                                    
                                    Text(selection.title ?? "NA")
                                        .foregroundColor(Color.white)
                                        .font(.system(.headline, design: .rounded, weight: .medium))
                                        .padding(.leading, 12)
                                }.frame(maxWidth: 210)
                            }
                            .padding(5)
                        }
                        .accentColor(Color.white)
                        
                    }
                }
                
            }
        }
    }
}

struct SingleRowView_Previews: PreviewProvider {
    static var previews: some View {
        SingleRowView(genre: "", selectionCatalog: [MovieModel(title: nil, year: nil, imdbID: nil, type: nil, poster: nil)])
    }
}

extension SingleRowView {

}
