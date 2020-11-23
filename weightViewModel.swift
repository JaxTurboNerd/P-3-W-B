//
//  weightViewModel.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/30/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import Combine
import Foundation

final class AircraftData: ObservableObject {
    //@Published var aircraftType = ""
    @Published var selectedAircraft = ""
    @Published var presentPicker = false
    @Published var basicWeight = "00000"
    @Published var savedDate = "MMM dd YYYY"
    //@Published var selectedLRT = ""
    //@Published var selectedAEW = ""
    @Published var alertTrigger = false
    @Published var aircraftIsLRT = false
    //@Published var aircraftIsAEW = false
    private var aircraftMoment = 37311.6
    
    
    //Fuel
    @Published var tank1 = 0
    @Published var tank2 = 0
    @Published var tank3 = 0
    @Published var tank4 = 0
    @Published var tank5 = 0
    
    //Position Weights:
    @Published var pilot            = 200
    @Published var copilot          = 200
    @Published var fe               = 200
    @Published var flightStaObs     = 0
    @Published var radarCompartment = 0
    @Published var portFwdObs       = 0
    @Published var stbFwdObs        = 0
    @Published var fwdCargo         = 0
    @Published var tfo1             = 0
    @Published var tfo2             = 0
    @Published var tfo3             = 0
    @Published var tfo4             = 0
    @Published var tfo5             = 0
    @Published var firstClassSeats  = 0
    @Published var portAftObs       = 0
    @Published var stbAftObs        = 0
    
    //Cargo:
    @Published var cargoB = 0
    @Published var cargoC = 0
    @Published var cargoD = 0
    @Published var cargoE = 0
    @Published var cargoF = 0
    @Published var cargoG = 0
    
    //Miscellaneous:
    @Published var bombBay = 0
    
    //Computed Propeties:
    var ZFW: String {
        String(Int(basicWeight)! + cargoWeight + positionWeights)
    }
    
    var grossWeight: String {
        String(Int(ZFW)! + totalFuel)
    }
    private var totalFuel:Int {
        tank1 + tank2 + tank3 + tank4 + tank5
    }
    
    private var lrtPositionWeights: Int {
        pilot + copilot + fe + flightStaObs + portFwdObs + stbFwdObs + fwdCargo + tfo1 + tfo2 + tfo3 + tfo4 + firstClassSeats + portAftObs + stbAftObs    }
    
    private var aewPositionWeights: Int {
        pilot + copilot + fe + flightStaObs +  fwdCargo + radarCompartment + tfo1 + tfo2 + tfo3 + tfo4 + firstClassSeats + portAftObs + stbAftObs
    }
    
    private var cargoWeight: Int {
        cargoB + cargoC + cargoD + cargoE + cargoF + cargoG + bombBay
    }
    
    private var positionWeights: Int {
        if self.aircraftIsLRT {
            return lrtPositionWeights
        }
        else {
            return aewPositionWeights
        }
    }
    
    private var totalMoment: Double {
        if aircraftIsLRT {
            return (Double(pilot) * 222.0) + (Double(copilot) * 222.0) + (Double(fe) * 227.0) + (Double(flightStaObs) * 256.0) + (Double(tfo1) * 572.0) + (Double(tfo2) * 572.0) +  (Double(tfo3) * 572.0) + (Double(tfo4) * 572.0) + (Double(firstClassSeats) * 768.0) + (Double(portAftObs) * 889.0) + (Double(stbAftObs) * 889.0) + (Double(cargoB) * 227.0) + (Double(cargoC) * 333.0) + (Double(cargoD) * 565.0) + (Double(cargoE) * 768.0) + (Double(cargoF) * 889.0) + (Double(cargoG) * 1021.0) + (Double(tank1) * 606.2) + (Double(tank2) * 624.5) + (Double(tank3) * 624.5) + (Double(tank4) * 606.2) + (Double(tank5) * 594.5) + (Double(bombBay) * 400.0) + (aircraftMoment * 1000.0)
        }
        else {
            return (Double(pilot) * 222.0) + (Double(copilot) * 222.0) + (Double(fe) * 227.0) + (Double(flightStaObs) * 256.0) + (Double(tfo1) * 572.0) + (Double(tfo2) * 572.0) + (Double(tfo3) * 572.0) + (Double(tfo4) * 572.0) + (Double(firstClassSeats) * 768.0) + (Double(portAftObs) * 889.0) + (Double(cargoB) * 227.0) + (Double(cargoC) * 333.0) + (Double(cargoD) * 565.0) + (Double(cargoE) * 768.0) + (Double(cargoF) * 889.0) + (Double(cargoG) * 1021.0) + (Double(tank1) * 606.2) + (Double(tank2) * 624.5) + (Double(tank3) * 624.5) + (Double(tank4) * 606.2) + (Double(tank5) * 594.5) + (Double(bombBay) * 400.0) + (aircraftMoment * 1000.0)
        }
    }
    
    private let leadingEdgeMAC = 545.9
    private let MAC = 168.7
    //private let datumCG = totalMoment/Double(grossWeight)!
    
    var cg: String {
        get {
            if !alertTrigger {
                return "0"
            }
            else {
                return String((((((totalMoment/Double(grossWeight)!) - leadingEdgeMAC)/MAC) * 1000.0).rounded())/10.0) // rounded to xx.x format
            }
        }
    }//end cg
    
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
        
     func saveWeights() {
        //Define date information:
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.savedDate = dateFormatter.string(from: currentDate)
        
        //Set User Default values:
        UserDefaults.standard.set(self.selectedAircraft, forKey: "selectedAircraft")
        UserDefaults.standard.set(self.grossWeight, forKey: "grossWeight")
        UserDefaults.standard.set(self.cg, forKey: "cg")
        UserDefaults.standard.set(self.basicWeight, forKey: "basicWeight")
        UserDefaults.standard.set(self.ZFW, forKey: "zfw")
        UserDefaults.standard.set(self.savedDate, forKey: "savedDate")
    }//end func setWeights
}//end class


