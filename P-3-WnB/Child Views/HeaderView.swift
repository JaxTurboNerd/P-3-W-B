//
//  HeaderView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 7/31/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    var body: some View {
        VStack(spacing: 20.0){
            Text("\(aircraftData.selectedAircraft) Weight & Balance")
                .font(.largeTitle)
            HStack{
                Spacer()
                HeaderSubView(label: "Basic Weight", weight: aircraftData.basicWeight)
                Spacer()
                ZfwSubView(label: "ZFW", weight: aircraftData.ZFW)
                Spacer()
                GrossWeightSubView(label: "Gross Weight", weight: aircraftData.grossWeight)
                Spacer()
                CGsubView(label: "C.G.", weight: String(aircraftData.cg))
                Spacer()
            }//end HStack
        }//end VStack
    }//end some View
}//end struct

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
       let aircraftData = AircraftData()
        return HeaderView().environmentObject(aircraftData)
    }
}
