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
    @Published var contentCatalog: [ContentModel] = []
    @Published var cancellables = Set<AnyCancellable>()
    
    // FETCHED SPECIFIC CONTENT DETAILS
    @Published var selectedContentDetails: ContentDetailsModel = ContentDetailsModel.dummyData[0]
    
    // FETCHED CONTENT FOR SHOWN HOMEVIEW SELECTION
    @Published var contentForLOTR: [ContentModel] = []
    @Published var contentForSpiderman: [ContentModel] = []
    @Published var contentForTOP10: [ContentModel] = []
    @Published var contentForBatman: [ContentModel] = []
    @Published var contentForParanormal: [ContentModel] = []
    
    enum contentType: String {
        case movie = "movie"
        case series = "series"
    }
    
    
    init() {
        
    }
    
    func sinkToContentCatalog() {
        dataService.$fetchedSearchModel
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (fetchedSearchModel) in
                if let result = fetchedSearchModel.search {
                    self?.contentCatalog = result
                } else {
                    print("MY ERROR: can't .sink to contentCatalog")
                }
                
            })
            .store(in: &cancellables)
    }
    
    func sinkToSelectedContentDetails() {
        dataService.$contentDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (contentDetails) in
                self?.selectedContentDetails = contentDetails
            }
            .store(in: &cancellables)
    }

    func getContentID(contentID: String?) {
        if let contentID = contentID {
            self.dataService.fetchContentDetails(contentID: contentID)
        } else {
            print("MY ERROR: content ID is nil, i guess..")
        }
    }
    
    func sinkToContentForLOTR() {
        dataService.$fetchedLOTR
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let content = fetchedMovieModel.search {
                    self?.contentForLOTR = content
                }else {
                    print("MY ERROR: can't .sink LOTR")
                }
            }
            .store(in: &cancellables)
    }
    
    func sinkToContentForSpiderman() {
        dataService.$fetchedSPIDERMAN
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let content = fetchedMovieModel.search {
                    self?.contentForSpiderman = content
                }else {
                    print("MY ERROR: can't .sink Spiderman")
                }
            }
            .store(in: &cancellables)
    }
    
    func sinkToContentForBatman() {
        dataService.$fetchedBATMAN
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let content = fetchedMovieModel.search {
                    self?.contentForBatman = content
                }else {
                    print("MY ERROR: can't .sink Batman")
                }
            }
            .store(in: &cancellables)
    }

    func sinkToContentForParanormal() {
        dataService.$fetchedPARANORMAL
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (fetchedMovieModel) in
                if let content = fetchedMovieModel.search {
                    self?.contentForParanormal = content
                }else {
                    print("MY ERROR: can't .sink Paranormal")
                }
            }
            .store(in: &cancellables)
    }
    
    func sinkToContentForTOP10() {
        $contentForLOTR
            .combineLatest($contentForSpiderman, $contentForBatman, $contentForParanormal)
            .receive(on: DispatchQueue.main)
            .map({ (pub1, pub2, pub3, pub4) in
                return pub1 + pub2 + pub3 + pub4
            })
            .sink { [ weak self ] (mergedContents) in
                self?.contentForTOP10 = mergedContents.shuffled()
            }
            .store(in: &cancellables)
    }
    
    
    
}
