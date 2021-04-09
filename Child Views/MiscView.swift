//
//  MiscView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 7/31/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct MiscView: View {
    @EnvironmentObject private var aircraftData:AircraftData
    var body: some View {
        VStack{
            HStack {
                Toggle(isOn: $aircraftData.generatorInstalled) {
                    Text("#1 Generator")
                        .font(.title2)
                }.frame(width: 190, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
                VertInputView(label: "Bomb Bay:", maxWeight: 2000, weight: $aircraftData.bombBay)
                    .padding(.vertical)
            }
            ButtonView()
                //.padding(.vertical)
        }//end VStack
    }//end some View
}//end struct

struct MiscView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return MiscView().environmentObject(aircraftData)
    }
}
