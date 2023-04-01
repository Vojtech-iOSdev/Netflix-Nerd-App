//
//  MovieModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 15.03.2023.
//


import Foundation


// MARK: - MovieModel
struct SearchModel: Codable {
    let search: [MovieModel]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    
    static let dummyData: [SearchModel] = [
        SearchModel(search: nil, totalResults: nil, response: nil),
        SearchModel(search: nil, totalResults: nil, response: nil)
    ]
}





