//
//  SaveFunctions.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 5/28/21.
//

import SwiftUI

extension ButtonView {
    func saveWeight(){
        //create an instance of a saved weight context:
        let newWeight = SavedWeight(context: viewContext)
        newWeight.date = Date()
        
        //check for empty selected aircraft:
        //error alert should prevent this from being set to NXXXSK.
        guard aircraftData.selectedAircraft != "" else {
            newWeight.aircraft = "NXXXSK"
            return
        }
        newWeight.aircraft = aircraftData.selectedAircraft
        newWeight.cg = aircraftData.cg
        newWeight.grossWeight = aircraftData.grossWeight
        newWeight.zfw = aircraftData.ZFW
        newWeight.missionType = aircraftData.missionType
        //provide unique identifier for each saved instance.  To be used for retrieval by the UUID?
        newWeight.id = UUID()
        
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

extension AircraftData {
    //Function to reset fuel values to Zero:
    func resetFuelWeights() {
        self.tank1 = 0
        self.tank2 = 0
        self.tank3 = 0
        self.tank4 = 0
        self.tank5 = 0
    }// end func resetFuelWeights
    
    //Function to reset cargo weights to Zero
    func resetCargoWeights() {
        self.cargoB = 0
        self.cargoC = 0
        self.cargoD = 0
        self.cargoE = 0
        self.cargoF = 0
        self.cargoG = 0
        self.bombBay = 0
    }//end func
    
    //Func to reset position Weights:
    func resetPositionWeights() {
        self.pilot = 0
        self.copilot = 0
        self.fe = 0
        self.flightStaObs = 0
        self.radarCompartment = 0
        self.portFwdObs = 0
        self.stbFwdObs = 0
        self.fwdCargo = 0
        self.tfo1 = 0
        self.tfo2 = 0
        self.tfo3 = 0
        self.tfo4 = 0
        self.tfo5 = 0
        self.firstClassSeats = 0
        self.portAftObs = 0
        self.stbAftObs = 0
    }//end func
}
