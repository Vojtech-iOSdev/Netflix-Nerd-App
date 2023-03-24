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
    
    // DOWNLOADED MOVIES
    @Published var searchedText: String = ""
    @Published var MovieCatalog: [MovieModel] = []
    @Published var cancellables = Set<AnyCancellable>()
    
    // DOWNLOADED SPECIFIC MOVIE
    @Published var selectedMovieDetails: DetailMovieModel = DetailMovieModel(title: nil, year: nil, rated: nil, released: nil, length: nil, genre: nil, director: nil, actors: nil, description: nil, poster: nil, rating: nil, type: nil, awards: nil)
    
    
    // FETCHED MOVIES FOR SHOWN HOMEVIEW SELECTION
    var selectionForLOTR: [MovieModel] = []
    var selectionForSPIDERMAN: [MovieModel] = []
    var selectionForBATMAN: [MovieModel] = []
    var selectionForPARANORMAL: [MovieModel] = []

    let randomSearchWords: [String] = ["lord", "spider", "batman", "paranormal"]
    
    
    init() {
        dataService.fetchLOTR()
        sinkToSelectionForLOTR()
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
    
    func sinkToSelectedMovieDetails(){
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
    
    //???????????? THIS FUNC IS WHAT???
    func loadHomeViewContent() {
        //self.dataService.fetchData(searchedText: randomSearchWords.randomElement())
    }
    
    func sinkToSelectionForLOTR(){
        dataService.$fetchedLOTR
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let unwrappedFetchedMovieModel = fetchedMovieModel.search {
                    self?.selectionForLOTR = unwrappedFetchedMovieModel
                }else {
                    print("MY ERROR: SPATNE PRIPSANE FETCHEDMOVIEMODEL PRO MOVIECATALOG")
                }
            }
            .store(in: &cancellables)
    }

    
}
