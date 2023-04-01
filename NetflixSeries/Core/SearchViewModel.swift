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
    
    let genres: [String] = ["The lord of the rings:", "Spiderman:", "Netflix TOP10 in the US:", "Batman:", "Parnormal Activities:"]
    let randomUrl: String = "https://media.istockphoto.com/id/525982128/cs/fotografie/agresivita-koček.jpg?s=1024x1024&w=is&k=20&c=y632ynYYyc3wS5FuPBgnyXeBNBC7JmjQNwz5Vl_PvI8="
    
    // DOWNLOADED MOVIES
    @Published var searchedText: String = ""
    @Published var MovieCatalog: [MovieModel] = []
    @Published var cancellables = Set<AnyCancellable>()
    
    // DOWNLOADED SPECIFIC MOVIE
    @Published var selectedMovieDetails: DetailMovieModel = DetailMovieModel.dummyData[0]
    // FETCHED MOVIES FOR SHOWN HOMEVIEW SELECTION
    @Published var selectionForLOTR: [MovieModel] = []
    @Published var selectionForSpiderman: [MovieModel] = []
    @Published var selectionForTOP10: [MovieModel] = []
    @Published var selectionForBatman: [MovieModel] = []
    @Published var selectionForParanormal: [MovieModel] = []
    
    
    init() {
        
    }
    
    func sinkToMovieCatalog() {
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
    
    func sinkToSelectedMovieDetails() {
        dataService.$movieDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (movieDetails) in
                self?.selectedMovieDetails = movieDetails
            }
            .store(in: &cancellables)
    }

    func getMovieID(movieID: String?) {
        if let movieID = movieID {
            self.dataService.fetchMovieDetails(movieID: movieID)
        } else {
            print("ERROR: MOVIE ID IS NIL I THINK..")
        }
    }
    
    func sinkToSelectionForLOTR() {
        dataService.$fetchedLOTR
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let LOTRSelection = fetchedMovieModel.search {
                    self?.selectionForLOTR = LOTRSelection
                    self?.selectionForTOP10.append(contentsOf: LOTRSelection)
                }else {
                    print("MY ERROR: CANT SINK LOTR")
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
                    self?.selectionForTOP10.append(contentsOf: spidermanSelection)
                }else {
                    print("MY ERROR: CANT SINK SPIDERMAN")
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
                    self?.selectionForTOP10.append(contentsOf: batmanSelection)
                }else {
                    print("MY ERROR: CANT SINK BATMAN")
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
                    self?.selectionForTOP10.append(contentsOf: paranormalSelection)

                }else {
                    print("MY ERROR: CANT SINK PARANORMAL")
                }
            }
            .store(in: &cancellables)
    }
    
}
