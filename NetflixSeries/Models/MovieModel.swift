//
//  MovieModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 15.03.2023.
//


import Foundation


// MARK: - MovieModel
struct MovieModel: Codable {
    let search: [SearchModel]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - SearchModel
struct SearchModel: Codable, Identifiable {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?
    
    // JUST TO CONFORM TO IDENTIFIABLE :)
    var id: String? { imdbID }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}



