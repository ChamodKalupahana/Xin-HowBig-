//
//  CoreDataManager.swift
//  How Big?
//
//  Created by User on 11/03/2025.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let context = PersistenceController.shared.context

    func fetchReferences() -> [ReferenceObjectInDatabase] {
        let request: NSFetchRequest<ReferenceObjectInDatabase> = ReferenceObjectInDatabase.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

    func saveReference(referenceObject : ReferenceObject) {
        let referenceObjectInDatabase = ReferenceObjectInDatabase(context: context)
        referenceObjectInDatabase.id = referenceObject.id
        referenceObjectInDatabase.name = referenceObject.name
        referenceObjectInDatabase.length = referenceObject.length
        referenceObjectInDatabase.image =
        "imageToAdd"
        referenceObjectInDatabase.numberOfDimensions =
        Int16(referenceObject.numberOfDimensions)
        
        if let height = referenceObject.height, let width = referenceObject.width {
            referenceObjectInDatabase.height =
            height
            referenceObjectInDatabase.width =
            width
        }
        

        do {
            try context.save()
        } catch {
            print("Failed to save reference: \(error)")
        }
    }
}
