//
//  FuelView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 7/31/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct FuelView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    var body: some View {
        VStack{
            Text("Fuel:  \(aircraftData.totalFuel)lbs")
                .font(.title)
            HStack{
                Spacer()
                VertInputView(label: "Tank 1:", maxWeight: 10900, weight: $aircraftData.tank1)
                VertInputView(label: "Tank 2:", maxWeight: 11300, weight: $aircraftData.tank2)
                VertInputView(label: "Tank 3:", maxWeight: 11300, weight: $aircraftData.tank3)
                VertInputView(label: "Tank 4:", maxWeight: 10900, weight: $aircraftData.tank4)
                Spacer()
            }//end HStack
                .padding(.vertical, 10.0)//end HStack
            VertInputView(label: "Tank 5:", maxWeight: 17900, weight: $aircraftData.tank5)
        }//end VStack
    }//end some View
}//end struct

struct FuelView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return FuelView().environmentObject(aircraftData)
    }
}
