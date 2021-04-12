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
    }
}

struct CargoView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return CargoView().environmentObject(aircraftData)
    }
}
