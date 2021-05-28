//
//  ZfwSubView.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 5/27/21.
//

import SwiftUI

struct ZfwSubView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    var label:String
    var weight:String
    
    var body: some View {
        ZStack {
            Rectangle()
                .colorInvert()
                .border(Color.gray, width: 2)
                .shadow(color: .gray, radius: 4, y: 4)
                .frame(width: 160.0, height: 85.0)
                .overlay(weightView)
        }//end ZStack
    }//end some view
    
    var weightView: some View {
        VStack(alignment: .center) {
            Text(label)
                .frame(width: 150.0)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
            Divider()
            Text("\(weight)")
                .frame(width: 90.0)
                .multilineTextAlignment(.center)
                .foregroundColor(aircraftData.zfwExceeded ? .red : .black)
        }//end VStack
    }
}
struct ZfwSubView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return ZfwSubView(label: "ZFW", weight: "65000").environmentObject(aircraftData)
    }
}
