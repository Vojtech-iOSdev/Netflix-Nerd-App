//
//  MyDataManager.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 15.03.2023.
//

import Foundation
import Combine

class MyDataManager {
    
    static let instance = MyDataManager()
    
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


    private init() {    }
    
    func fetchData(searchedText: String) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(searchedText.lowercased())") else { return print("MY BAD URL ERROR: SPATNE URL") }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            //.debounce(for: .seconds(0.9) , scheduler: DispatchQueue.main)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("COMPLETION1: \(completion)")
                case .failure(let error):
                    print("COMPLETION1: \(error)")
                }
            } receiveValue: { [weak self] (moviesDownloaded) in
                self?.fetchedMovieModel = moviesDownloaded
                print("FETCHED MOVIE PRIPSANO Z MOVIES DOWNLOADED")
            }
            .store(in: &cancelFetchMovieDetails)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                print("MY BAD URL REPSPONSE ERROR: SPATNE VSEHCNOOO")
                throw URLError(.badServerResponse)
              }
        print("GOOD URL REPSPONSE!!")
        return output.data
    }
    
    func fetchMovieDetails(movieID: String) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(movieID)") else {
            return print("ERROR: BAD URL")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: DetailMovieModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("COMPLETION ERROR WHILE FETCHING MOVIE_DETAILS: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (detailMovieModel) in
                self?.movieDetails = detailMovieModel
            }
            .store(in: &cancelFetchMovieDetails)
        
        
    }
        
    
}
