//
//  CustomPickerView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/26/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct CustomPickerView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    
    var aircraftList = [String]()
    let basicWeights: [String:String]
    let aircraftMoments: [String:Double]
    
    @Binding var presentPicker: Bool
    @Binding var selectedAircraft: String
    @Binding var basicWeight: String
    @Binding var aircraftMoment: Double
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            VStack {
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Button(action: {//Cancel button
                            withAnimation{
                                self.aircraftData.presentPicker = false
                            }
                        }){
                            Text("Cancel")
                        }//end Button
                        .padding(10)
                        Spacer()
                    }//end HStack
                        .background(Color(UIColor.darkGray))
                        .foregroundColor(Color.white)
                    Text("tap an aircraft to select it")
                        .font(.caption)
                        .padding(.leading,10)
                    List{
                        ForEach(aircraftList, id: \.self){item in
                            Button(action: {
                                //code when user taps on the aircraft
                                self.aircraftData.selectedAircraft = item
                                //code to set selectedLRT/AEW variables:
                                switch item {
                                case "N144CS", "N145CS", "N146CS", "N147CS", "N149CS":
                                    //next line used for setting the background color as error alert
                                    self.aircraftData.aircraftIsLRT = false
                                case "N403SK", "N480SK", "N741SK":
                                    self.aircraftData.aircraftIsLRT = true
                                default:
                                    break
                                }//end switch
                                for (key, value) in self.basicWeights {
                                    if self.aircraftData.selectedAircraft == key {
                                        self.aircraftData.basicWeight = value
                                    }
                                }
                                for (key, value) in self.aircraftMoments {
                                    if self.aircraftData.selectedAircraft == key {
                                        self.aircraftData.aircraftMoment = value
                                    }
                                }
                                withAnimation {
                                    self.aircraftData.presentPicker = false
                                }
                                self.aircraftData.alertTrigger = true
                            }){
                                Text(item)
                            }
                        }//end ForEach
                    }
                }//end VStack
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(width: 200, height: 300)
                .padding(.horizontal, 10)
                .padding(.top, 20)
                Spacer()
            }//end VStack
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomPickerView_Previews: PreviewProvider {
    static let sampleData = ["N403SK", "N480SK", "N741SK", "N769SK"]
    static let sampleBasics = ["N403SK": "63914.5", "N480SK": "66413.9", "N741SK":"64692.1", "N769SK":"66000"]
    static let sampleMoments = ["N403SK": 39000.0, "N480SK": 38777.0, "N741SK": 37345.0, "N769SK": 38453.0]
    static var previews: some View {
        CustomPickerView(aircraftList: sampleData, basicWeights: sampleBasics, aircraftMoments: sampleMoments, presentPicker: Binding.constant(true), selectedAircraft: Binding.constant("N741SK"), basicWeight: Binding.constant("66000"), aircraftMoment: Binding.constant(39000.0))
    }
}
