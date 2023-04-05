//
//  SelectionRowsView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.03.2023.
//

import SwiftUI

struct SelectionRowsView: View {

    @StateObject private var vm: SearchViewModel = SearchViewModel()

    var body: some View {
        VStack {
            // COLUMNS
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    SingleRowView(genre: vm.genres[0],selectionCatalog: vm.selectionForLOTR)
                        .onAppear {
                            vm.sinkToSelectionForLOTR()
                            // get image from cache 
                            // save sink func result to NSCache
                            // and insert GET func from NSCache to selection catalog
                            // so in Single row will just be cached content!!!
                            // also i need to cancel all sink func after first call
                        }
                    SingleRowView(genre: vm.genres[1],selectionCatalog: vm.selectionForSpiderman)
                        .onAppear {
                            vm.sinkToSelectionForSpiderman()
                        }
                    SingleRowView(genre: vm.genres[2],selectionCatalog: vm.selectionForTOP10.shuffled())
                    SingleRowView(genre: vm.genres[3],selectionCatalog: vm.selectionForBatman)
                        .onAppear {
                            vm.sinkToSelectionForBatman()
                        }
                    SingleRowView(genre: vm.genres[4],selectionCatalog: vm.selectionForParanormal)
                        .onAppear {
                            vm.sinkToSelectionForParanormal()
                        }

                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct RowsForRecommendedHomeContent_Previews: PreviewProvider {
    static var previews: some View {
        SelectionRowsView()
    }
}
