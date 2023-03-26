//
//  DataManager.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 15.03.2023.
//

import Foundation
import Combine

class DataManager {
    
    static let instance = DataManager()
    
    // API STUFF
    let apiKey: String = "c2e5cb16"
    let urlBase: String = "https://www.omdbapi.com/?apikey=c2e5cb16&"
    // more detail info on OMBD API website
    
    // FETCHED MOVIES
    @Published var fetchedMovieModel: SearchModel = SearchModel(search: nil, totalResults: nil, response: nil)
    var cancelFetchData = Set<AnyCancellable>()
    
    // FETCHED SPECIFFIC MOVIE
    @Published var movieDetails: DetailMovieModel = DetailMovieModel(title: nil, year: nil, rated: nil, released: nil, length: nil, genre: nil, director: nil, actors: nil, description: nil, poster: nil, rating: nil, type: nil, awards: nil)
    var cancelFetchMovieDetails = Set<AnyCancellable>()
    
    // FETCHED MOVIES FOR SHOWN HOMEVIEW SELECTION
    @Published var fetchedLOTR: SearchModel = SearchModel(search: nil, totalResults: nil, response: nil)
    @Published var fetchedSPIDERMAN: SearchModel = SearchModel(search: nil, totalResults: nil, response: nil)
    @Published var fetchedBATMAN: SearchModel = SearchModel(search: nil, totalResults: nil, response: nil)
    @Published var fetchedPARANORMAL: SearchModel = SearchModel(search: nil, totalResults: nil, response: nil)
    var cancelFetchAllSelections = Set<AnyCancellable>()
    
    enum randomSearchWords: String {
        case lotr = "lord"
        case spiderman = "spider"
        case batman = "batman"
        case paranormal = "paranormal"
    }


    private init() {
        fetchLOTR()
        fetchSpiderman()
        fetchBatman()
        fetchParanormal()
        
    }
    
    func fetchData(searchedText: String) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(searchedText.lowercased())") else { return print("MY BAD: SPATNE URL") }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (moviesDownloaded) in
                self?.fetchedMovieModel = moviesDownloaded
            })
            .store(in: &cancelFetchData)
    }
    
    
    func fetchMovieDetails(movieID: String) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(movieID)") else {
            return print("ERROR: BAD URL")
        }
        
        NetworkingManager.download(url: url)
            .decode(type: DetailMovieModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (detailMovieModel) in
                self?.movieDetails = detailMovieModel
            })
            .store(in: &cancelFetchMovieDetails)
        
        
    }
    
    func fetchLOTR() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.lotr.rawValue)") else { return print("MY BAD: SPATNE URL") }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (moviesDownloaded) in
                self?.fetchedLOTR = moviesDownloaded
                print("fetchedLOTR")
            })
            .store(in: &cancelFetchAllSelections)
    }
    
    func fetchSpiderman() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.spiderman.rawValue)") else { return print("MY BAD: SPATNE URL") }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (moviesDownloaded) in
                self?.fetchedSPIDERMAN = moviesDownloaded
                print("fetchedSPIDER")
            })
            .store(in: &cancelFetchAllSelections)
    }
    
    func fetchBatman() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.batman.rawValue)") else { return print("MY BAD: SPATNE URL") }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (moviesDownloaded) in
                self?.fetchedBATMAN = moviesDownloaded
                print("fetchedBATMAN")
            })
            .store(in: &cancelFetchAllSelections)
    }

    func fetchParanormal() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.paranormal.rawValue)") else { return print("MY BAD: SPATNE URL") }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (moviesDownloaded) in
                self?.fetchedPARANORMAL = moviesDownloaded
                print("fetchedPARA")
            })
            .store(in: &cancelFetchAllSelections)
    }


    
}
