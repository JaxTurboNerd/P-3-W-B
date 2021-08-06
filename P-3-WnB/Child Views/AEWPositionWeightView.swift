//
//  AEWPositionWeightView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/24/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct AEWPositionWeightView: View {
    @EnvironmentObject private var aircraftData: AircraftData

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(self.aircraftData.selectedAircraft)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .frame(width: 200, height: 55)
                    .background(Color.clear)
                Spacer()
                Text("Select Aircraft")
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(width: 200, height: 55)
                    .background(!aircraftData.alertTrigger ? Color.red: aircraftData.aircraftIsLRT ? Color.red: Color.green).opacity(0.6)
                    .cornerRadius(10)
                    .onTapGesture {
                        self.aircraftData.showLrtList = false
                        self.aircraftData.presentPicker = true
                        self.aircraftData.alertTrigger = false
                }
                Spacer()
                
                VStack(spacing: 10.0) {
                    HorizontalInputView(label: "Pilot:", maxWeight: 500, weight: $aircraftData.pilot)
                    HorizontalInputView(label: "Co-Pilot:", maxWeight: 500, weight: $aircraftData.copilot)
                    HorizontalInputView(label: "FE", maxWeight: 500, weight: $aircraftData.fe)
                    HorizontalInputView(label: "Flight Sta Obs:", maxWeight: 500, weight: $aircraftData.flightStaObs)
                    HorizontalInputView(label: "Radar Bay:", maxWeight: 500, weight: $aircraftData.radarCompartment)
                    HorizontalInputView(label: "TFO1:", maxWeight: 500, weight: $aircraftData.tfo1)
                    HorizontalInputView(label: "TFO2:", maxWeight: 500, weight: $aircraftData.tfo2)
                    Group{
                        HorizontalInputView(label: "TFO3:", maxWeight: 500, weight: $aircraftData.tfo3)
                        HorizontalInputView(label: "TFO4:", maxWeight: 500, weight: $aircraftData.tfo4)
                        HorizontalInputView(label: "TFO5:", maxWeight: 500, weight: $aircraftData.tfo5)
                        HorizontalInputView(label: "First Class Seats:", maxWeight: 1000, weight: $aircraftData.firstClassSeats)
                        HorizontalInputView(label: "Port Aft Obs:", maxWeight: 500, weight: $aircraftData.portAftObs)
                        HorizontalInputView(label: "Stb Aft Obs:", maxWeight: 500, weight: $aircraftData.stbAftObs)
                    }//end Group
                }//end VStack
                Spacer()
            }//end VStack
            .popover(isPresented: $aircraftData.presentPicker, attachmentAnchor: .point(.center), arrowEdge: .top, content: {
                AircraftUserInfo()
            })
        }//end ZStack
    }//end some View
}

struct AEWPositionWeightView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return AEWPositionWeightView().environmentObject(aircraftData)
    }
}
