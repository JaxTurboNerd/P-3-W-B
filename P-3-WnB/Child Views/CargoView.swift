//
//  CargoView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 7/31/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct CargoView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    var body: some View {
        HStack {
            Spacer()
            VStack{
                Text("Cargo Area:")
                    .font(.title)
                HorizontalInputView(label: "B:", maxWeight: 2000, weight: $aircraftData.cargoB)
                HorizontalInputView(label: "C:", maxWeight: 2000, weight: $aircraftData.cargoC)
                HorizontalInputView(label: "D:", maxWeight: 2000, weight: $aircraftData.cargoD)
                HorizontalInputView(label: "E:", maxWeight: 2000, weight: $aircraftData.cargoE)
                HorizontalInputView(label: "F:", maxWeight: 2000, weight: $aircraftData.cargoF)
                HorizontalInputView(label: "G:", maxWeight: 2000, weight: $aircraftData.cargoG)
            }//end VStack
            Spacer()
            VStack {
                VertInputView(label: "Bomb Bay:", maxWeight: 2000, weight: $aircraftData.bombBay)
                    .padding()
                Text(aircraftData.generatorInstalled ? "#1 Generator Installed": " #1 Generator NOT Installed")
                    .onTapGesture {
                        aircraftData.generatorInstalled.toggle()
                    }
                    .frame(width: 120, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(aircraftData.generatorInstalled ? Color.green.opacity(0.8): Color.yellow.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3),
                            radius: 10, x: 0, y: 10)
            }//end VStack
            .padding()
        }//end HStack
        .padding()
    }
}

struct CargoView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return CargoView().environmentObject(aircraftData)
    }
}
