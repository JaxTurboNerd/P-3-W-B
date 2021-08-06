//
//  BasicWeightsLRT.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 5/29/21.
//

import SwiftUI

extension LRTPositionWeightView {
    //Picker View set up in the LRTPositionWeight View:
    @State static var aircraft = ["N403SK", "N480SK", "N741SK", "N769SK"]
    
    @State static var LRTbasicWeights = ["N403SK": 63915,
                                         "N480SK": 66414,
                                         "N741SK": 64692]
    @State static var LRTMoments = [     "N403SK": 36747.8,
                                         "N480SK": 38398.6,
                                         "N741SK": 37311.6]
}

extension AEWPositionWeightView {
    @State static var aircraft = ["N144CS", "N145CS", "N146CS", "N147CS", "N148CS", "N149CS"]
    
    @State static var AEWbasicWeights = [   "N144CS": 71932,
                                            "N145CS": 71927,
                                            "N146CS": 72179,
                                            "N149CS": 72510]
    @State static var AEWMoments = [        "N144CS": 42256.7,
                                            "N145CS": 42212.1,
                                            "N146CS": 42232.4,
                                            "N149CS": 42482.1]
}

