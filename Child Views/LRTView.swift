//
//  LRTView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 7/31/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct LRTView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView()
                Divider()
                HStack {
                    LRTPositionWeightView()
                        .padding(.leading)
                        .padding(.bottom)
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
}//end LRT View

struct LRTView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return LRTView().environmentObject(aircraftData)
    }
}
