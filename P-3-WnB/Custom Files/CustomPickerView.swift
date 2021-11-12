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
    
    @Binding var presentPicker: Bool
    @Binding var selectedAircraft: String
    
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
                                case "N144CS", "N145CS", "N146CS", "N147CS", "N148CS", "N149CS":
                                    self.aircraftData.aircraftIsLRT = false
                                case "N403SK", "N480SK", "N741SK", "N769SK":
                                    self.aircraftData.aircraftIsLRT = true
                                default:
                                    break
                                }//end switch
                                withAnimation {
                                    self.aircraftData.presentPicker = false
                                }
                                self.aircraftData.alertTrigger = true
                                self.aircraftData.screenJustLoaded = false
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
    static var previews: some View {
        CustomPickerView(aircraftList: sampleData, presentPicker: Binding.constant(true), selectedAircraft: Binding.constant("N741SK"))
    }
}
