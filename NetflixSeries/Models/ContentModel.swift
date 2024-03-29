//
//  ContentModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 20.03.2023.
//

import Foundation


struct ContentModel: Codable, Identifiable {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?
    
    var id: String? { imdbID }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
    
    static let dummyData: [ContentModel] = [
        ContentModel(title: "Hello America, i am right here!", year: "2022", imdbID: "IDK", type: .movie, poster: "URL for a movie"),
        ContentModel(title: "Hello America, i am right here!", year: "2022", imdbID: "IDK", type: .movie, poster: "URL for a movie")
    ]
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}


