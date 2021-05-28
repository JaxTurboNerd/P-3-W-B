//
//  AEWView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/24/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct AEWView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView()
                Divider()
                HStack {
                    AEWPositionWeightView()
                        .padding(.leading)
                    VStack{
                        FuelView()
                        Divider()
                        CargoView()
                        Divider()
                        MiscView()
                    }
                    .padding(.trailing)
                }//end HStack
            }//end VStack
            .padding()
        }
    }//end some View
}//end AEW View

struct AEWView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return AEWView().environmentObject(aircraftData)
    }
}
