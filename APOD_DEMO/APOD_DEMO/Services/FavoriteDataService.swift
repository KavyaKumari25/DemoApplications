//
//  FavoriteDataService.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 28/02/22.
//

import Foundation
import CoreData

class FavoriteDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "FavoriteListContainer"
    private let entityName = "NasaRecordEntity"
    
    @Published var savedEntities: [NasaRecordEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, Error) in
            if let error = Error {
                print("Error loading core data \(error)")
            }
        }
        self.getFavoriteListData()
    }
    
    func updateFavoriteList(nasaData: NasaDataModelProtocol) {
        if let entity = savedEntities.first(where: { $0.title == nasaData.title }) {
            delete(entity: entity)
        } else {
            add(nasaData: nasaData)
        }
    }
    
    private func getFavoriteListData() {
        let request = NSFetchRequest<NasaRecordEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching NasaRecord Entities \(error)")
        }
    }
    
//    func isEntryExists(nasaData: NasaDataModelProtocol) -> Bool {
//        if let entity = savedEntities.first(where: { $0.title == nasaData.title }) {
//            return true
//        }
//        return false
//    }
    
    private func add(nasaData: NasaDataModelProtocol) {
        let entity = NasaRecordEntity(context: container.viewContext)
        entity.id = nasaData.id
        entity.title = nasaData.title
        entity.copyright = nasaData.copyright
        entity.date = nasaData.date
        entity.mediaType = nasaData.mediaType
        entity.explaination = nasaData.explanation
        entity.imageUrl = nasaData.imageURLString
        self.applyChanges()
    }
    
     func delete(entity: NasaRecordEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getFavoriteListData()
    }
}
