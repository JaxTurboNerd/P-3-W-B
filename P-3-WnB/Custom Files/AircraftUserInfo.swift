//
//  AircraftUserInfo.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 7/19/21.
//

import SwiftUI

struct AircraftUserInfo: View {
    @EnvironmentObject private var aircraftData: AircraftData
        
    @Binding var presentPicker: Bool
    @Binding var selectedAircraft: String
    @Binding var basicWeight: Int
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
                                .font(.title2)
                        }//end Button
                        .padding(10)
                        Spacer()
                    }//end HStack
                        .background(Color(UIColor.darkGray))
                        .foregroundColor(Color.white)
                    Text("Enter aircraft info:")
                        .font(.callout)
                        .padding(.leading,10)
                    List{
                        HStack {
                            Text("Aircraft Number:")
                                .multilineTextAlignment(.trailing)
                                .frame(width: 160, height: 50)
                                
                            Divider()
                            TextField("Aircraft", text: $selectedAircraft)
                                .multilineTextAlignment(.center)
                        }
                        .font(.title2)
                        
                        HStack{
                            Text("    Basic Weight:")
                                .frame(width: 160, height: 50)
                                .multilineTextAlignment(.trailing)
                            Divider()
                            NumberTextField(value: $basicWeight, maxValue: 75000)
                        }
                        .font(.title2)
                        HStack {
                            Text("Aircraft Moment:")
                                .frame(width: 160, height: 50)
                                .multilineTextAlignment(.trailing)
                            Divider()
                            NumberTextField(value: $aircraftMoment, maxValue: 37000)
                        }
                        .font(.title2)
                    }
                }//end VStack
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(width: 400, height: 300)
                .padding(.horizontal, 10)
                .padding(.top, 20)
                Spacer()
            }//end VStack
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    
    }
}

struct AircraftUserInfo_Previews: PreviewProvider {
    
    static var previews: some View {
        AircraftUserInfo(presentPicker: Binding.constant(true), selectedAircraft: Binding.constant("N741SK"), basicWeight: Binding.constant(65000), aircraftMoment: Binding.constant(37000.0))
    }
}
