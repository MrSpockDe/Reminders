//
//  CoreDataManager.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import Foundation
import CoreData

/// The single CoreDataManager Object.
class CoreDataManager {
    let persistentContainer: NSPersistentContainer

    /// only one shared CoreDataManager Object willbe used
    static let shared = CoreDataManager()

    private init() {
        ValueTransformer.setValueTransformer(
            NSColorTransformer(),
            forName: NSValueTransformerName("NSColorTransformer"))
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load Store: \(error.localizedDescription)")
            }
        }
    }
}
