//
//  PositionWeightView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 7/31/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct LRTPositionWeightView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    
    var body: some View {
        ZStack {
            VStack{
                Text(self.aircraftData.selectedAircraft)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .frame(width: 200, height: 55)
                    .background(Color.clear)
                Text("Select Aircraft")
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(width: 200, height: 55)
                    .background(aircraftData.aircraftIsLRT ? Color.green: Color.red).opacity(0.6)
                    .cornerRadius(10)
                    .onTapGesture {
                        self.aircraftData.presentPicker = true
                        self.aircraftData.aircraftIsLRT = true
                    }
                
                VStack(spacing: 10.0) {
                    HorizontalInputView(label: "Pilot:", maxWeight: 500, weight: $aircraftData.pilot)
                    HorizontalInputView(label: "Co-Pilot:", maxWeight: 500, weight: $aircraftData.copilot)
                    HorizontalInputView(label: "FE:", maxWeight: 500, weight: $aircraftData.fe)
                    HorizontalInputView(label: "Flight Sta. Obs:", maxWeight: 500, weight: $aircraftData.flightStaObs)
                    HorizontalInputView(label: "Port Fwd Obs:", maxWeight: 500, weight: $aircraftData.portFwdObs)
                    HorizontalInputView(label: "Stb Fwd Obs:", maxWeight: 500, weight: $aircraftData.stbFwdObs)
                    HorizontalInputView(label: "Fwd Cargo Area:", maxWeight: 500, weight: $aircraftData.fwdCargo)
                    HorizontalInputView(label: "TFO1:", maxWeight: 500, weight: $aircraftData.tfo1)
                    HorizontalInputView(label: "TFO2:", maxWeight: 500, weight: $aircraftData.tfo2)
                    Group{
                        HorizontalInputView(label: "TFO3:", maxWeight: 500, weight: $aircraftData.tfo3)
                        HorizontalInputView(label: "TFO4:", maxWeight: 500, weight: $aircraftData.tfo4)
                        HorizontalInputView(label: "First Class Seats:", maxWeight: 1000, weight: $aircraftData.firstClassSeats)
                        HorizontalInputView(label: "Port Aft Obs:", maxWeight: 500, weight: $aircraftData.portAftObs)
                        HorizontalInputView(label: "Stb Aft Obs:", maxWeight: 500, weight: $aircraftData.stbAftObs)
                    }//end Group
                }//end VStack
                Spacer()
            }//end VStack
            .padding(.horizontal)
            if aircraftData.presentPicker {
                CustomPickerView(aircraftList: LRTPositionWeightView.aircraft.sorted(), basicWeights: LRTPositionWeightView.LRTbasicWeights, aircraftMoments: LRTPositionWeightView.LRTMoments, presentPicker: $aircraftData.presentPicker, selectedAircraft: $aircraftData.selectedAircraft, basicWeight: $aircraftData.basicWeight, aircraftMoment: $aircraftData.aircraftMoment)
            }
        }//end ZStack
    }//end some View
    
}//end struct

struct PositionWeightView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return LRTPositionWeightView().environmentObject(aircraftData)
    }
}
