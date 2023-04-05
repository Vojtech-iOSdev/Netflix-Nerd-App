//
//  SearchViewModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 15.03.2023.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    let dataService = DataManager.instance
    
    let genres: [String] = ["The lord of the rings:", "Spiderman:", "Netflix TOP10 in the US:", "Batman:", "Paranormal Activity:"]
    let randomUrl: String = "https://media.istockphoto.com/id/525982128/cs/fotografie/agresivita-koček.jpg?s=1024x1024&w=is&k=20&c=y632ynYYyc3wS5FuPBgnyXeBNBC7JmjQNwz5Vl_PvI8="
    
    // FETCHED CONTENT
    @Published var searchedText: String = ""
    @Published var movieCatalog: [MovieModel] = []
    @Published var cancellables = Set<AnyCancellable>()
    
    // FETCHED SPECIFIC CONTENT DETAILS
    @Published var selectedContentDetails: DetailMovieModel = DetailMovieModel.dummyData[0]
    
    // FETCHED CONTENT FOR SHOWN HOMEVIEW SELECTION
    @Published var selectionForLOTR: [MovieModel] = []
    @Published var selectionForSpiderman: [MovieModel] = []
    @Published var selectionForTOP10: [MovieModel] = []
    @Published var selectionForBatman: [MovieModel] = []
    @Published var selectionForParanormal: [MovieModel] = []
    
    enum contentType: String {
        case movie
        case series
    }
    
    
    init() {
        
    }
    
    func sinkToMovieCatalog() {
        dataService.$fetchedMovieModel
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (fetchedMovieModel) in
                if let unwrappedFetchedMovieModel = fetchedMovieModel.search {
                    self?.movieCatalog = unwrappedFetchedMovieModel
                } else {
                    print("MY ERROR: can't .sink to movieCatalog")
                }
                
            })
            .store(in: &cancellables)
    }
    
    func sinkToSelectedMovieDetails() {
        dataService.$movieDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (contentDetails) in
                self?.selectedContentDetails = contentDetails
            }
            .store(in: &cancellables)
    }

    func getMovieID(movieID: String?) {
        if let movieID = movieID {
            self.dataService.fetchMovieDetails(movieID: movieID)
        } else {
            print("MY ERROR: movie ID is nil, i guess..")
        }
    }
    
    func sinkToSelectionForLOTR() {
        dataService.$fetchedLOTR
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let LOTRSelection = fetchedMovieModel.search {
                    self?.selectionForLOTR = LOTRSelection
                }else {
                    print("MY ERROR: can't .sink LOTR")
                }
            }
            .store(in: &cancellables)
    }
    
    func sinkToSelectionForSpiderman() {
        dataService.$fetchedSPIDERMAN
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let spidermanSelection = fetchedMovieModel.search {
                    self?.selectionForSpiderman = spidermanSelection
                }else {
                    print("MY ERROR: can't .sink Spiderman")
                }
            }
            .store(in: &cancellables)
    }
    
    func sinkToSelectionForBatman() {
        dataService.$fetchedBATMAN
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let batmanSelection = fetchedMovieModel.search {
                    self?.selectionForBatman = batmanSelection
                }else {
                    print("MY ERROR: can't .sink Batman")
                }
            }
            .store(in: &cancellables)
    }

    func sinkToSelectionForParanormal() {
        dataService.$fetchedPARANORMAL
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let paranormalSelection = fetchedMovieModel.search {
                    self?.selectionForParanormal = paranormalSelection
                }else {
                    print("MY ERROR: can't .sink Paranormal")
                }
            }
            .store(in: &cancellables)
    }
    
    func sinkToSelectionForTOP10() {
        $selectionForLOTR
            .combineLatest($selectionForSpiderman, $selectionForBatman, $selectionForParanormal)
            .receive(on: DispatchQueue.main)
            .map({ (pub1, pub2, pub3, pub4) in
                return pub1 + pub2 + pub3 + pub4
            })
            .sink { [ weak self ] (mergedSelections) in
                self?.selectionForTOP10 = mergedSelections.shuffled()
            }
            .store(in: &cancellables)
    }
    
    
    
}
