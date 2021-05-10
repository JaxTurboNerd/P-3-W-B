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
                Spacer()
                
                Spacer()
            }//end HStack
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
