//
//  SeriesModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 21.02.2023.
//

import Foundation
import SwiftUI

struct Series: Identifiable {
    
    let id: String = UUID().uuidString
    
    let title: String
    let image: String
    let description: String
    let releasseDate: String
    let rating: Double
    let mainActors: [String]
    let numberOfSeasons: String
    let tvGenre: String
}

var TVShows: [Series] = [
    Series(title: "Breaking Bad",
           image: "BreakingBad",
           description: "Walter White, a chemistry teacher, discovers that he has cancer and decides to get into the meth-making business to repay his medical debts. His priorities begin to change when he partners with Jesse.",
           releasseDate: "January 20, 2008",
           rating: 9.8,
           mainActors: ["Bryan Cranston", "Aaron Paul", "Anna Gunn"],
           numberOfSeasons: "5 seasons",
           tvGenre: "Drama"),
    
    Series(title: "Peaky Blinders",
           image: "PeakyBlinders",
           description: "Tommy Shelby, a dangerous man, leads the Peaky Blinders, a gang based in Birmingham. Soon, Chester Campbell, an inspector, decides to nab him and put an end to the criminal activities.",
           releasseDate: "September 12, 2013",
           rating: 9.9,
           mainActors: ["Cillian Murphy", "Helen McCrory", "Paul Anderson"],
           numberOfSeasons: "6 seasons",
           tvGenre: "Drama"),
    
    Series(title: "La Casa De Papel",
           image: "LaCasaDePapel",
           description: "A criminal mastermind who goes by " + "The Professor" + " has a plan to pull off the biggest heist in recorded history -- to print billions of euros in the Royal Mint of Spain. To help him carry out the ambitious plan, he recruits eight people with certain abilities and who have nothing to lose.",
           releasseDate: "May 2, 2017",
           rating: 10,
           mainActors: ["Álvaro Morte", "Úrsula Corberó", "Alba Flores"],
           numberOfSeasons: "5 seasons",
           tvGenre: "Thriller"),
    
    Series(title: "The Sandman",
           image: "TheSandman",
           description: "When the Sandman, aka Dream, the cosmic being who controls all dreams, is captured and held prisoner for more than a century, he must journey across different worlds and timelines to fix the chaos his absence has caused.",
           releasseDate: "August 5, 2022",
           rating: 9.9,
           mainActors: ["Tom Sturridge", "Gwendoline Christie", "Jenna Coleman"],
           numberOfSeasons: "1 season",
           tvGenre: "Drama"),
    
    Series(title: "Our Planet",
           image: "OurPlanet",
           description: "Experiencing the planet's natural beauty through an examination of how climate change impacts all living creatures in this ambitious documentary of spectacular scope.",
           releasseDate: "April 5, 2019",
           rating: 10,
           mainActors: ["David Attenborough", "Penélope Cruz"],
           numberOfSeasons: "1 season",
           tvGenre: "Nature documentary"),
    
    Series(title: "Wednesday",
           image: "Wednesday",
           description: "While attending Nevermore Academy, Wednesday Addams attempts to master her emerging psychic ability, thwart a killing spree and solve the mystery that embroiled her parents 25 years ago.",
           releasseDate: "November 23, 2022",
           rating: 9.8,
           mainActors: ["Jenna Ortega", "Emma Myers", "Catherine Zeta-Jones"],
           numberOfSeasons: "1 season",
           tvGenre: "Comedy horror"),
    
    Series(title: "Dark",
           image: "Dark",
           description: "When two children go missing in a small German town, its sinful past is exposed along with the double lives and fractured relationships that exist among four families as they search for the kids. The mystery-drama series introduces an intricate puzzle filled with twists that includes a web of curious characters, all of whom have a connection to the town's troubled history -- whether they know it or not. The story includes supernatural elements that tie back to the same town in 1986. " + "Dark" + " represents the first German original series produced for Netflix.",
           releasseDate: "December 1, 2017",
           rating: 9.9,
           mainActors: ["Louis Hofmann", "Lisa Vicari", "Oliver Masucci"],
           numberOfSeasons: "3 seasons",
           tvGenre: "Mystery")
]
