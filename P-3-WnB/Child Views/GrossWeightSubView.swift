//
//  GrossWeightSubView.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 5/27/21.
//

import SwiftUI

struct GrossWeightSubView: View {
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
                .foregroundColor(aircraftData.isOverWeight ? .red : .black)
        }//end VStack
    }//end weightView
}

struct GrossWeightSubView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return GrossWeightSubView(label: "Gross Weight", weight: "100000").environmentObject(aircraftData)
    }
}
