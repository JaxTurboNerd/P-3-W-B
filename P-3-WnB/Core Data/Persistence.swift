//
//  Persistence.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 4/11/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    //Set up for the preview function:
    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        
        for _ in 0..<10 {
            let newItem = SavedWeight(context: viewContext)
            newItem.aircraft = "N741SK"
            newItem.cg = "30.0"
            newItem.copilot = "200"
            newItem.date = Date()
            newItem.fe = "200"
            newItem.flStaObs = "0"
            newItem.grossWeight = "115000"
            newItem.missionType = "Mission"
            newItem.pilot = "200"
        }
        do {
            try viewContext.save()
        }catch {
            let nsError = error as NSError
            fatalError("Unresolved Error \(nsError), \(nsError.userInfo)")
        }
        return result
        
    }()
    
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
