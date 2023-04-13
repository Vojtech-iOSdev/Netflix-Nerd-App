//
//  CoreDataManager.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 08.04.2023.
//

import SwiftUI
import CoreData

class CoreDataManager: ObservableObject {
    
    static let shared: CoreDataManager = CoreDataManager()
    
    
    func saveData(context: NSManagedObjectContext, content: [ContentDetailsModel]) {
        
        content.forEach { item in
            let entity = ContentDetailsEntity(context: context)
            entity.title = item.title
            entity.poster = item.poster
            entity.description2 = item.description
            
            do {
                try context.save()
                print("success")
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
}
