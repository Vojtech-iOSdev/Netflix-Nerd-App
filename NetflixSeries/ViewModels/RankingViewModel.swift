//
//  RankingViewModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 15.03.2023.
//

import Foundation
import SwiftUI
import Combine

class RankingViewModel: ObservableObject {
    
    let dataService = MyDataManager.instance
    
    // DOWNLOADED MOVIES
    @Published var MovieCatalog: [SearchModel] = []
    @Published var searchedText: String = ""
    
    @Published var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func addSubscribers() {
        dataService.$fetchedMovieModel
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (fetchedMovieModel) in
                if let unwrappedFetchedMovieModel = fetchedMovieModel.search {
                    self?.MovieCatalog = unwrappedFetchedMovieModel
                } else {
                    print("MY ERROR: SPATNE PRIPSANE FETCHEDMOVIEMODEL PRO MOVIECATALOG")
                }
                
            })
            .store(in: &cancellables)


    }
    
}
