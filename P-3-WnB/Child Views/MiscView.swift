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
    @State private var pickerSelection: String = "Mission"
    let missionTypes:[String] = ["Mission", "Transit", "Training", "Other"]
    
    var body: some View {
        VStack{
            HStack {
                Text("Flight Profile: ")
                Picker(selection: $pickerSelection,
                       label: //This basically does nothing:
                        HStack {
                            Text("Flight Profile:")
                        }
                       ,
                       content: {
                        ForEach(missionTypes, id: \.self, content: {
                            Text($0)
                                .tag($0)
                                .font(.largeTitle)//not working
                        })
                })
                    .pickerStyle(.menu)//This is the default
            }//end HStack
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(15)
            
            ButtonView()
                .padding(.top)
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
