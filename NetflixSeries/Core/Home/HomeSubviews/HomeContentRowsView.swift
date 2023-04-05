//
//  HomeContentRowsView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.03.2023.
//

import SwiftUI

struct HomeContentRowsView: View {

    @StateObject private var vm: SearchViewModel = SearchViewModel()

    var body: some View {
        VStack {
            // COLUMNS
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 20) {
                    SingleRowView(genre: vm.genres[0],contentCatalog: vm.contentForLOTR)
                    SingleRowView(genre: vm.genres[1],contentCatalog: vm.contentForSpiderman)
                    SingleRowView(genre: vm.genres[2],contentCatalog: vm.contentForTOP10)
                    SingleRowView(genre: vm.genres[3],contentCatalog: vm.contentForBatman)
                    SingleRowView(genre: vm.genres[4],contentCatalog: vm.contentForParanormal)
                }
                .task {
                    vm.sinkToContentForLOTR()
                    vm.sinkToContentForSpiderman()
                    vm.sinkToContentForTOP10()
                    vm.sinkToContentForBatman()
                    vm.sinkToContentForParanormal()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct RowsForRecommendedHomeContent_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentRowsView()
    }
}
