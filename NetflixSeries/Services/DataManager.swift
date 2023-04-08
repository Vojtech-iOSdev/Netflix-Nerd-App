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
    @Published var fetchedSearchModel: SearchModel = SearchModel.dummyData[0]
    var cancelFetchSearchContent = Set<AnyCancellable>()
    
    // FETCHED SPECIFFIC MOVIE
    @Published var contentDetails: ContentDetailsModel = ContentDetailsModel.dummyData[0]
    var cancelFetchContentDetails = Set<AnyCancellable>()
    
    // FETCHED MOVIES FOR SHOWN HOMEVIEW SELECTION
    @Published var fetchedLOTR: SearchModel = SearchModel.dummyData[0]
    @Published var fetchedSPIDERMAN: SearchModel = SearchModel.dummyData[0]
    @Published var fetchedBATMAN: SearchModel = SearchModel.dummyData[0]
    @Published var fetchedPARANORMAL: SearchModel = SearchModel.dummyData[0]
    var cancelFetchAllSelections = Set<AnyCancellable>()
    
    enum randomSearchWords: String {
        case lotr = "lord"
        case spiderman = "spider"
        case batman = "batman"
        case paranormal = "paranormal"
    }
    
    private init() { }
    
    func fetchSearchContent(searchedText: String) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(searchedText.lowercased())") else { return print(NetworkingManager.NetworkingError.invalidURL) }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (contentDownloaded) in
                self?.fetchedSearchModel = contentDownloaded
            })
            .store(in: &cancelFetchSearchContent)
    }
    
    
    func fetchContentDetails(contentID: String) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(contentID)") else {
            return print(NetworkingManager.NetworkingError.invalidURL) }
        
        
        NetworkingManager.download(url: url)
            .decode(type: ContentDetailsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (ContentDetaisModel) in
                self?.contentDetails = ContentDetaisModel
            })
            .store(in: &cancelFetchContentDetails)
        
        
    }
    
    func fetchLOTR() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.lotr.rawValue)") else { return print(NetworkingManager.NetworkingError.invalidURL) }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (contentDownloaded) in
                self?.fetchedLOTR = contentDownloaded
            })
            .store(in: &cancelFetchAllSelections)
    }
    
    func fetchSpiderman() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.spiderman.rawValue)") else { return print(NetworkingManager.NetworkingError.invalidURL) }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (contentDownloaded) in
                self?.fetchedSPIDERMAN = contentDownloaded
            })
            .store(in: &cancelFetchAllSelections)
    }
    
    func fetchBatman() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.batman.rawValue)") else { return print(NetworkingManager.NetworkingError.invalidURL) }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (contentDownloaded) in
                self?.fetchedBATMAN = contentDownloaded
            })
            .store(in: &cancelFetchAllSelections)
    }

    func fetchParanormal() {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(randomSearchWords.paranormal.rawValue)") else { return print(NetworkingManager.NetworkingError.invalidURL) }
        
        NetworkingManager.download(url: url)
            .decode(type: SearchModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                   receiveValue: { [weak self] (contentDownloaded) in
                self?.fetchedPARANORMAL = contentDownloaded
            })
            .store(in: &cancelFetchAllSelections)
    }


    
}
