//
//  WeightExceeded.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 5/28/21.
//

import Foundation
import Combine

extension AircraftData {
    
    var isOverWeight: Bool {
        if (selectedAircraft == "N741SK" && (Int(grossWeight)! > 127500)) {
            return true
        }else if ((selectedAircraft == "N403SK" || selectedAircraft == "N480SK") && (Int(grossWeight)! > 135000)){
            return true
        }else if (!aircraftIsLRT && (Int(grossWeight)! > 135000)) {
            return true
        }else {return false}
    }
    
    var zfwExceeded: Bool {
        if (selectedAircraft == "N741SK" && (Int(ZFW)! > 71584)) {
            return true
        }else if ((selectedAircraft == "N403SK" || selectedAircraft == "N480SK") && (Int(ZFW)! > 77200)){
            return true
        }else if (!aircraftIsLRT && (Int(ZFW)! > 77200)) {
            return true
        }else {return false}
    }
    
    var cgExceeded: Bool {
        //Heavy weight aircraft have a different CG graph -> different aft limits
        if (!aircraftIsLRT && ((Double(cg)!) > 30.0)){
            return true
        }else if ((selectedAircraft == "N403SK" || selectedAircraft == "N480SK") && ((Double(cg)!) > 30.0)){
            return true
        }else if (aircraftIsLRT && (Double(cg)! > 29.5)){
            return true
        }else {return false}
    }
}
