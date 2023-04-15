//
//  CoreDataManager.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 08.04.2023.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = .init()
    
    let container: NSPersistentContainer
    
    
    private init() {
        container = NSPersistentContainer(name: "ContentDataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading CoreData \(error)")
            }
            
        }
    }
    
    func fetchCoreData() -> [ContentDetailsEntity] {
        let request = NSFetchRequest<ContentDetailsEntity>(entityName: "ContentDetailsEntity")
        let sort = NSSortDescriptor(keyPath: \ContentDetailsEntity.order, ascending: true)
        request.sortDescriptors = [sort]
        
        var results: [ContentDetailsEntity] = []
        
        do {
            results = try container.viewContext.fetch(request)
            
        } catch {
            print("Error fetching CoreData: \(error.localizedDescription)")
        }
        
        return results
    }
    
    func addToFavourites(content: ContentDetailsModel) {
        
        let fetchedResults = fetchCoreData()
        
        let newlyAddedContent = ContentDetailsEntity(context: container.viewContext)
        newlyAddedContent.title = content.title
        newlyAddedContent.poster = content.poster
        newlyAddedContent.description2 = content.description
        newlyAddedContent.order = (fetchedResults.last?.order ?? 0) + 1
        
        saveData()
    }
    
    func deleteFromFavourites(indexSet: IndexSet, savedContent: [ContentDetailsEntity]) {
        guard let index = indexSet.first else { return }
        let savedEntity = savedContent[index]
        container.viewContext.delete(savedEntity)
        
        saveData()
    }
    
    func moveItemInFavourites(from source: IndexSet, to destination: Int) {
        let fetchedResults = fetchCoreData()
        
        let itemToMove = source.first!
        
        if itemToMove < destination {
            var startIndex = itemToMove + 1
            let endIndex = destination - 1
            var startOrder = fetchedResults[itemToMove].order
            while startIndex <= endIndex {
                fetchedResults[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            fetchedResults[itemToMove].order = startOrder
        }
        else if itemToMove > destination {
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder = fetchedResults[destination].order + 1
            let newOrder = fetchedResults[destination].order
            while startIndex <= endIndex {
                fetchedResults[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            fetchedResults[itemToMove].order = newOrder
        }
        
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            //fetchCoreData()
        } catch {
            print("Error saving to CoreData \(error)")
        }
    }
    
//    static let shared: CoreDataManager = .init()
//
//    func saveData(context: NSManagedObjectContext, content: [ContentDetailsModel]) {
//
//        content.forEach { item in
//            let entity = ContentDetailsEntity(context: context)
//            entity.title = item.title
//            entity.poster = item.poster
//            entity.description2 = item.description
//
//            do {
//                try context.save()
//                print("success")
//            } catch {
//                print(error.localizedDescription)
//            }
//
//        }
//    }
    
}
