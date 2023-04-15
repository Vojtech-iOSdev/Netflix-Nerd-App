//
//  NetflixSeriesApp.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 21.02.2023.
//

import SwiftUI

@main
struct NetflixSeriesApp: App {
    
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}
