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
    
    //Picker view setup:
    //@State private var pickerSelection: String = "Mission"
    let missionTypes:[String] = ["Mission", "Transit", "Training", "Other"]
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Picker(selection: $aircraftData.missionType,
                       label:
                        HStack {
                            Text("Flight Profile:")
                            Text(aircraftData.missionType)
                        }
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.3),
                                radius: 10, x: 0, y: 10)
                       ,
                       content: {
                        ForEach(missionTypes, id: \.self, content: {option in
                            Text(option)
                                .tag(option).font(.headline)
                                
                        })
                })
                    .pickerStyle(MenuPickerStyle())
                Spacer()
            }//end HStack
            .padding()
            ButtonView()
            Spacer()
        }//end VStack
        .padding()
    }//end some View
}//end struct

struct MiscView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return MiscView().environmentObject(aircraftData)
    }
}
