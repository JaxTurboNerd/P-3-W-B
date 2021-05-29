//
//  SaveFunctions.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 5/28/21.
//

import SwiftUI

extension ButtonView {
    func saveWeight(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let newWeight = SavedWeight(context: viewContext)
        newWeight.date = Date()
        
        //check for empty selected aircraft:
        guard aircraftData.selectedAircraft != "" else {
            newWeight.aircraft = "NXXXSK"
            return
        }
        newWeight.aircraft = aircraftData.selectedAircraft
        newWeight.cg = aircraftData.cg
        newWeight.grossWeight = aircraftData.grossWeight
        newWeight.zfw = aircraftData.ZFW
        newWeight.missionType = aircraftData.missionType
        
        do {
            try viewContext.save()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error.localizedDescription)")
        }//end try-catch
    }//end saveWeight function
    
    //This function determines if the user has an LRT selected while on the AEW view and tries to save the existing data...or vice versa (AEW selected while on the LRT View
    func determineViewMismatch(){
        //On the LRT tab with an AEW aircraft selected:
        if (self.aircraftData.viewSelected == 0 && !self.aircraftData.aircraftIsLRT){
            self.aircraftData.aircraftViewMismatch = true
        } else if
            //On the AEW tab with an LRT aircraft selected:
            (self.aircraftData.viewSelected == 1 && self.aircraftData.aircraftIsLRT){
            self.aircraftData.aircraftViewMismatch = true
        } else {
            self.aircraftData.aircraftViewMismatch = false
        }
    }//end func
}
