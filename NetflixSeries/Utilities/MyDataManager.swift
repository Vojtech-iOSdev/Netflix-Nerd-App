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
    @Published var fetchedMovieModel: MovieModel = MovieModel(search: nil, totalResults: nil, response: nil)

    
    var cancellables = Set<AnyCancellable>()
        private init() {
        //downloadData()
    }
    
    func downloadData(searchedText: String) {
        // old url from email with just 1 example: "https://www.omdbapi.com/?i=tt3896198&apikey=c2e5cb16"
        // new url from website with my key(c2e5cb16) : "https://www.omdbapi.com/?apikey=c2e5cb16&"
        let apiKey: String = "c2e5cb16"
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(searchedText.lowercased())") else { return print("MY BAD URL ERROR: SPATNE URL") }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            //.debounce(for: .seconds(0.9) , scheduler: DispatchQueue.main)
            .decode(type: MovieModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished:
                    print("COMPLETION1: \(completion)")
                case .failure(let error):
                    print("COMPLETION1: \(error)")
                }
            } receiveValue: { [weak self] (moviesDownloaded) in
                self?.fetchedMovieModel = moviesDownloaded
                print("FETCHED MOVIE PRIPSANO Z MOVIES DOWNLOADED")
            }
            .store(in: &cancellables)
    }
    
//    func filteredResults(searchTerm: String) -> [SearchModel] {
//        if searchTerm.isEmpty{
//            return self.allDownloadedSearches
//        }else{
//            return self.allDownloadedSearches.filter{
//                $0.title!.localizedStandardContains(searchTerm)
//            }
//        }
//    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                print("MY BAD URL REPSPONSE ERROR: SPATNE VSEHCNOOO")
                throw URLError(.badServerResponse)
              }
        print("GOOD URL REPSPONSE!!")
        return output.data
    }
}
