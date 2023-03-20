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
    
    let dataService = MyDataManager.instance
    
    // DOWNLOADED MOVIES
    @Published var searchedText: String = ""
    @Published var MovieCatalog: [MovieModel] = []
    @Published var cancellables = Set<AnyCancellable>()
    
    // DOWNLOADED SPECIFIC MOVIE
    @Published var selectedMovieDetails: DetailMovieModel = DetailMovieModel(title: nil, year: nil, rated: nil, released: nil, length: nil, genre: nil, director: nil, actors: nil, description: nil, poster: nil, rating: nil, type: nil, awards: nil)
    
    // HOMEVIEW PRELOADED CONTENT
    enum randomSearchWordss: String {
        case lord = "lord" // The lord of the rings
        case spider = "spider" // Spider-man
        case batman = "batman" // Batman obviously xdd
        case paranormal = "paranormal" // Paranormal activity
    }
    let randomSearchWords: [String] = ["lord", "spider", "batman", "paranormal"]
    
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
    
    func loadHomeViewContent() {
        //self.dataService.fetchData(searchedText: randomSearchWords.randomElement())
    }
}
