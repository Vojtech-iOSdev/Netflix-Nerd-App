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
                    SingleRowView(genre: vm.genres[1],selectionCatalog: vm.selectionForSpiderman)
                    // CHANGE THE SELCTION CATALOT FOR GENRES[2] TO MIXED ONE !!!
                    SingleRowView(genre: vm.genres[2],selectionCatalog: vm.selectionForSpiderman)
                    SingleRowView(genre: vm.genres[3],selectionCatalog: vm.selectionForBatman)
                    SingleRowView(genre: vm.genres[4],selectionCatalog: vm.selectionForParanormal)

                }
            }
        }.padding(.horizontal)    }
}

struct RowsForRecommendedHomeContent_Previews: PreviewProvider {
    static var previews: some View {
        SelectionRowsView()
    }
}


