//
//  SelectionRowsView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.03.2023.
//

import SwiftUI

struct SelectionRowsView: View {
    // MARK: PROPERTIES
    @StateObject private var vm: SearchViewModel = SearchViewModel()

    
    
   // MARK: BODY
    var body: some View {
        VStack {
            // COLUMNS
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    SingleRowView(genre: vm.genres[0],selectionCatalog: vm.selectionForLOTR)
                    SingleRowView(genre: vm.genres[1],selectionCatalog: vm.selectionForSPIDERMAN)
                    // CHANGE THE SELCTION CATALOT FOR GENRES[2] TO MIXED ONE !!!
                    SingleRowView(genre: vm.genres[2],selectionCatalog: vm.selectionForSPIDERMAN)
                    SingleRowView(genre: vm.genres[3],selectionCatalog: vm.selectionForBATMAN)
                    SingleRowView(genre: vm.genres[4],selectionCatalog: vm.selectionForPARANORMAL)

                }
            }
        }.padding(.horizontal)    }
}

// MARK: PREVIEW
struct RowsForRecommendedHomeContent_Previews: PreviewProvider {
    static var previews: some View {
        SelectionRowsView()
    }
}

// MARK: COMPONENTS
extension SelectionRowsView {
    
//    private var seriesElement: some View {
//        ScrollView(.horizontal, showsIndicators: true) {
//            HStack(spacing: 0) {
//                ForEach(vm.selectionForLOTR) { selection in
//                    NavigationLink(destination: MovieDetailView(movieSelected: selection)) {
//                        VStack(alignment: .leading, spacing: 12) {
//                            AsyncImage(url: URL(string: selection.poster ?? randomUrl)) { returnedImage in
//                                switch returnedImage {
//                                case .empty:
//                                    ProgressView()
//                                case .success (let image):
//                                    image
//                                        .resizable()
//                                        .frame(width: 200, height: 120, alignment: .leading)
//                                        .background(Color.red)
//                                        .scaledToFill()
//                                        .cornerRadius(10)
//                                        .shadow(color: Color.white.opacity(0.2), radius: 5, x: 0, y: 5)
//                                case .failure (_):
//                                    Image(systemName: "xmark")
//                                default:
//                                    Image(systemName: "xmark")
//                                }
//                            }
//
//                            Text(selection.title ?? "NA")
//                                .foregroundColor(Color.white)
//                                .font(.system(.headline, design: .rounded, weight: .medium))
//                                .padding(.leading, 12)
//                        }.frame(maxWidth: 210)
//                    }
//                    .padding(5)
//                }
//                .accentColor(Color.white)
//
//            }
//        }
//    }
    
    
//    func top10SeriesElement(genre: String) -> some View {
//        VStack(alignment: .leading, spacing: 1) {
//            // sections
//            Section(header: Text(genre)
//                .foregroundColor(Color.white)
//                .font(.system(.title2, design: .rounded, weight: .bold))
//                .padding(.leading, 0)
//            ) {
//                // top10SeriesElement with NavigationLink
//                ScrollView(.horizontal, showsIndicators: true) {
//                    HStack(spacing: 0) {
//                        ForEach(CatalogOfContent.tvShows.shuffled()) { series in
//                            NavigationLink(destination: SeriesDetailView(selectedSeries: series)) {
//                                VStack(alignment: .center, spacing: 12) {
//                                    Image(series.image)
//                                        .resizable()
//                                        .frame(width: 200, height: 300, alignment: .leading)
//                                        .background(Color.red)
//                                        .scaledToFill()
//                                        .shadow(color: Color.white.opacity(0.2), radius: 8, x: 0, y: 0)
//
//                                    Text(series.title)
//                                        .foregroundColor(Color.white)
//                                        .font(.system(.headline, design: .rounded, weight: .regular))
//                                        .padding(.leading, 12)
//
//                                }.padding(10)
//                            }
//                        }
//                    }
//                }
//            }
//        }.padding(.vertical, 20)
//    }
    
}
