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
        if (aircraftIsLRT && (Int(grossWeight)! > 127500)) {
            return true
        }else if (!aircraftIsLRT && (Int(grossWeight)! > 135000)){
            return true
        }else {return false}
    }
    
    var zfwExceeded: Bool {
        if (aircraftIsLRT && (Int(ZFW)! > 71584)) {
            return true
        }else if (!aircraftIsLRT && (Int(ZFW)! > 77200)){
            return true
        } else {return false}
    }
    
    var cgExceeded: Bool {
        if (Double(cg)! > 29.0) {
            return true
        }
        
        return false
    }
}
