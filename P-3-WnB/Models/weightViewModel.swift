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
    @Published var selectedAircraft = ""
    @Published var presentPicker = false
    @Published var basicWeight = "00000"
    @Published var savedDate = "MMM dd YYYY"
    @Published var alertTrigger = false
    @Published var aircraftIsLRT = false
    @Published var aircraftMoment = 39000.0
    @Published var showSavedAlert = false
    @Published var generatorInstalled = true
    @Published var missionType = "Other"
    @Published var aircraftViewMismatch = false
    @Published var viewSelected = 0
    @Published var screenJustLoaded = true
    
    //Fuel
    @Published var tank1 = 0 {
        //if user input exceeds 10900 -> set to the max of 10900
        didSet {
            if tank1 > 11000 && oldValue <= 11000{
                tank1 = oldValue
            }
        }
    }
    @Published var tank2 = 0 {
        didSet {
            if tank2 > 11500 && oldValue <= 11500{
                tank2 = oldValue
            }
        }
    }
    @Published var tank3 = 0 {
        didSet {
            if tank3 > 11500 && oldValue <= 11500{
                tank3 = oldValue
            }
        }
    }
    
    @Published var tank4 = 0 {
        didSet {
            if tank4 > 11000 && oldValue <= 11000{
                tank4 = oldValue
            }
        }
    }
    
    @Published var tank5 = 0 {
        didSet {
            if tank5 > 17900 && oldValue <= 17900{
                tank5 = oldValue
            }
        }
    }
    
    //Position Weights:
    @Published var pilot = 200 {
        didSet {
            if pilot > 500 && oldValue <= 500 {
                pilot = oldValue
            }
        }
    }
    @Published var copilot = 200 {
        didSet {
            if copilot > 500 && oldValue <= 500 {
                copilot = oldValue
            }
        }
    }
    @Published var fe = 200 {
        didSet {
            if fe > 500 && oldValue <= 500{
                fe = oldValue
            }
        }
    }
    @Published var flightStaObs = 0 {
        didSet {
            if flightStaObs > 500 && oldValue <= 500{
                flightStaObs = oldValue
            }
        }
    }
    @Published var radarCompartment = 0 {
        didSet {
            if radarCompartment > 500 && oldValue <= 500{
                radarCompartment = oldValue
            }
        }
    }
    @Published var portFwdObs = 0 {
        didSet {
            if portFwdObs > 500 && oldValue <= 500{
                portFwdObs = oldValue
            }
        }
    }
    @Published var stbFwdObs = 0 {
        didSet {
            if stbFwdObs > 500 && oldValue <= 500{
                stbFwdObs = oldValue
            }
        }
    }
    @Published var fwdCargo = 0 {
        didSet {
            if fwdCargo > 500 && oldValue <= 500{
                fwdCargo = oldValue
            }
        }
    }
    @Published var tfo1 = 0 {
        didSet {
            if tfo1 > 500 && oldValue <= 500{
                tfo1 = oldValue
            }
        }
    }
    @Published var tfo2 = 0 {
        didSet {
            if tfo2 > 500 && oldValue <= 500{
                tfo2 = oldValue
            }
        }
    }
    @Published var tfo3 = 0 {
        didSet {
            if tfo3 > 500 && oldValue <= 500{
                tfo3 = oldValue
            }
        }
    }
    @Published var tfo4 = 0 {
        didSet {
            if tfo4 > 500 && oldValue <= 500{
                tfo4 = oldValue
            }
        }
    }
    
    @Published var tfo5 = 0 {
        didSet {
            if tfo5 > 500 && oldValue <= 500{
                tfo5 = oldValue
            }
        }
    }
    @Published var firstClassSeats = 0 {
        didSet {
            if firstClassSeats > 1000 && oldValue <= 1000{
                firstClassSeats = oldValue
            }
        }
    }
    @Published var portAftObs = 0 {
        didSet {
            if portAftObs > 500 && oldValue <= 500{
                portAftObs = oldValue
            }
        }
    }
    @Published var stbAftObs = 0 {
        didSet {
            if stbAftObs > 500 && oldValue <= 500{
                stbAftObs = oldValue
            }
        }
    }
    
    //Cargo:
    @Published var cargoB = 0 {
        didSet {
            if cargoB > 2000 && oldValue <= 2000{
                cargoB = oldValue
            }
        }
    }
    @Published var cargoC = 0 {
        didSet {
            if cargoC > 2000 && oldValue <= 2000{
                cargoC = oldValue
            }
        }
    }
    @Published var cargoD = 0 {
        didSet {
            if cargoD > 2000 && oldValue <= 2000{
                cargoD = oldValue
            }
        }
    }
    @Published var cargoE = 0 {
        didSet {
            if cargoE > 2000 && oldValue <= 2000{
                cargoE = oldValue
            }
        }
    }
    @Published var cargoF = 0 {
        didSet {
            if cargoF > 2000 && oldValue <= 2000{
                cargoF = oldValue
            }
        }
    }
    @Published var cargoG = 0 {
        didSet {
            if cargoG > 2000 && oldValue <= 2000{
                cargoG = oldValue
            }
        }
    }
    
    //Miscellaneous:
    @Published var bombBay = 0 {
        didSet {
            if bombBay > 2000 && oldValue <= 2000{
                bombBay = oldValue
            }
        }
    }
    
    //Computed Propeties:
    var ZFW: String {
        String(Int(basicWeight)! + cargoWeight + positionWeights)
    }
    
    var grossWeight: String {
        String(Int(ZFW)! + totalFuel)
    }
    
    //Generator:
    private var generator: Int {
        if(generatorInstalled){
            return 108
        }
        else {return 0}
    }
    
    var totalFuel:Int {
        tank1 + tank2 + tank3 + tank4 + tank5
    }
    
    private var lrtPositionWeights: Int {
        pilot + copilot + fe + flightStaObs + portFwdObs + stbFwdObs + fwdCargo + tfo1 + tfo2 + tfo3 + tfo4 + firstClassSeats + portAftObs + stbAftObs
    }
    
    private var aewPositionWeights: Int {
        pilot + copilot + fe + flightStaObs + radarCompartment + tfo1 + tfo2 + tfo3 + tfo4 + tfo5 + firstClassSeats + portAftObs + stbAftObs
    }
    
    private var cargoWeight: Int {
        cargoB + cargoC + cargoD + cargoE + cargoF + cargoG + bombBay + generator
    }
    
    private var positionWeights: Int {
        if self.aircraftIsLRT {
            return lrtPositionWeights
        }
        else {
            return aewPositionWeights
        }
    }
    
    //compute fuel moments based on their full capacity:
    private var tank1Moment: Double {
        switch tank1 {
        case 0...2725:
            return 614.7
        case 2726...5450:
            return 612.3
        case 5451...8175:
            return 609.4
        case 8176...10900:
            return 606.2
        default:
            return 606.2
        }
    }
    
    private var tank2Moment: Double {
        switch tank2 {
        case 0...2825:
            return 623.1
        case 2286...5650:
            return 628.8
        case 5651...8475:
            return 627.2
        case 8476...11300:
            return 624.5
        default:
            return 624.5
        }
    }
    
    private var tank3Moment: Double {
        switch tank3 {
        case 0...2825:
            return 623.1
        case 2286...5650:
            return 628.8
        case 5651...8475:
            return 627.2
        case 8476...11300:
            return 624.5
        default:
            return 624.5
        }
    }
    
    private var tank4Moment: Double {
        switch tank4 {
        case 0...2725:
            return 614.7
        case 2726...5450:
            return 612.3
        case 5451...8175:
            return 609.4
        case 8176...10900:
            return 606.2
        default:
            return 606.2
        }
    }
    
    private var tank5Moment: Double {
        switch tank5 {
        case 0...4475:
            return 583.0
        case 4476...8950:
            return 591.5
        case 8951...13425:
            return 594.5
        case 13426...17900:
            return 591.5
        default:
            return 591.5
        }
    }
    
    private var totalMoment: Double {
        if aircraftIsLRT {
            return ((Double(pilot) * 222.0) + (Double(copilot) * 222.0) + (Double(fe) * 227.0) + (Double(flightStaObs) * 256.0) + (Double(portFwdObs) * 333.0) + (Double(stbFwdObs) * 333.0) + (Double(fwdCargo) * 380.0) + (Double(tfo1) * 565.0) + (Double(tfo2) * 565.0) +  (Double(tfo3) * 565.0) + (Double(tfo4) * 565.0) + (Double(firstClassSeats) * 768.0) + (Double(portAftObs) * 889.0) + (Double(stbAftObs) * 889.0) + (Double(cargoB) * 227.0) + (Double(cargoC) * 333.0) + (Double(cargoD) * 565.0) + (Double(cargoE) * 768.0) + (Double(cargoF) * 889.0) + (Double(cargoG) * 1021.0) + (Double(tank1) * tank1Moment) + (Double(tank2) * tank2Moment) + (Double(tank3) * tank3Moment) + (Double(tank4) * tank4Moment) + (Double(tank5) * tank5Moment) + (Double(bombBay) * 400.0) + (Double(aircraftMoment) * 1000.0)) + (Double(generator) * 576.0)
        }
        else {
            return ((Double(pilot) * 222.0) + (Double(copilot) * 222.0) + (Double(fe) * 227.0) + (Double(flightStaObs) * 256.0) + (Double(radarCompartment) * 333.0) + (Double(tfo1) * 565.0) + (Double(tfo2) * 565.0) + (Double(tfo3) * 565.0) + (Double(tfo4) * 565.0) + (Double(tfo5) * 565.0) + (Double(firstClassSeats) * 768.0) + (Double(portAftObs) * 889.0) + (Double(stbAftObs) * 889.0) + (Double(cargoB) * 227.0) + (Double(cargoC) * 333.0) + (Double(cargoD) * 565.0) + (Double(cargoE) * 768.0) + (Double(cargoF) * 889.0) + (Double(cargoG) * 1021.0) + (Double(tank1) * tank1Moment) + (Double(tank2) * tank2Moment) + (Double(tank3) * tank3Moment) + (Double(tank4) * tank4Moment) + (Double(tank5) * tank5Moment) + (Double(bombBay) * 400.0) + (Double(aircraftMoment) * 1000.0)) + (Double(generator) * 576.0)
        }
    }
    
    private let leadingEdgeMAC = 545.9
    private let MAC = 168.7
    
    var cg: String {
        get {
            //This is so CG will show 0 when the app first starts.
            if screenJustLoaded {
                return "0"
            }
            else {
                return String((((((totalMoment/Double(grossWeight)!) - leadingEdgeMAC)/MAC) * 1000.0).rounded())/10.0)
                // rounded to xx.x format
            }
        }//end get
    }//end cg
}//end class


