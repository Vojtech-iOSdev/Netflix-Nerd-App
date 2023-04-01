//
//  DetailMovieModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 20.03.2023.
//

import Foundation

struct DetailMovieModel: Decodable {
    let title: String?
    let year: String?
    let rated: String?
    let released: String?
    let length: String?
    let genre: String?
    let director: String?
    let actors: String?
    let description: String?
    let poster: String?
    let rating: String?
    let type: String?
    let awards: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case length = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case description = "Plot"
        case poster = "Poster"
        case rating = "imdbRating"
        case type = "Type"
        case awards = "Awards"
    }
    
    static let dummyData: [DetailMovieModel] = [
        DetailMovieModel(title: nil, year: nil, rated: nil, released: nil, length: nil, genre: nil, director: nil, actors: nil, description: nil, poster: nil, rating: nil, type: nil, awards: nil),
        DetailMovieModel(title: nil, year: nil, rated: nil, released: nil, length: nil, genre: nil, director: nil, actors: nil, description: nil, poster: nil, rating: nil, type: nil, awards: nil)
    ]
}


// JSON example
/*
 {
   "Title": "Batman",
   "Year": "1989",
   "Rated": "PG-13",
   "Released": "23 Jun 1989",
   "Runtime": "126 min",
   "Genre": "Action, Adventure",
   "Director": "Tim Burton",
   "Writer": "Bob Kane, Sam Hamm, Warren Skaaren",
   "Actors": "Michael Keaton, Jack Nicholson, Kim Basinger",
   "Plot": "The Dark Knight of Gotham City begins his war on crime with his first major enemy being Jack Napier, a criminal who becomes the clownishly homicidal Joker.",
   "Language": "English, French, Spanish",
   "Country": "United States, United Kingdom",
   "Awards": "Won 1 Oscar. 10 wins & 26 nominations total",
   "Poster": "https://m.media-amazon.com/images/M/MV5BZDNjOGNhN2UtNmNhMC00YjU4LWEzMmUtNzRkM2RjN2RiMjc5XkEyXkFqcGdeQXVyMTU0OTM5ODc1._V1_SX300.jpg",
   "Ratings": [
     {
       "Source": "Internet Movie Database",
       "Value": "7.5/10"
     },
     {
       "Source": "Rotten Tomatoes",
       "Value": "73%"
     },
     {
       "Source": "Metacritic",
       "Value": "69/100"
     }
   ],
   "Metascore": "69",
   "imdbRating": "7.5",
   "imdbVotes": "383,053",
   "imdbID": "tt0096895",
   "Type": "movie",
   "DVD": "22 Aug 1997",
   "BoxOffice": "$251,409,241",
   "Production": "N/A",
   "Website": "N/A",
   "Response": "True"
 }
*/
