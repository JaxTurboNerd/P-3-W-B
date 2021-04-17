//
//  Persistence.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 4/11/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "P-3Wnb")
        
        container.loadPersistentStores{(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error.localizedDescription)")
            }
        }
    }//end init()
    
    func deleteProfile(profile: SavedWeight) {
        container.viewContext.delete(profile)
        do {
            try container.viewContext.save()
        }catch {
            container.viewContext.rollback()
            print("Failed to delete \(error.localizedDescription)")
        }
    }
}//end struct
