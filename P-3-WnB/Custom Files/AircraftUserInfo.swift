//
//  AircraftUserInfo.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 7/19/21.
//

import SwiftUI

struct AircraftUserInfo: View {
    @EnvironmentObject private var aircraftData: AircraftData
    @State private var moment = ""
    private let lrtList = ["N403SK", "N480SK", "N741SK", "N769SK"]
    private let aewList = ["N144CS", "N145CS", "N146CS", "N147CS", "N148CS",                            "N149CS"]
        
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
                        Button(action: {
                            withAnimation {
                                self.aircraftData.presentPicker = false
                            }
                        }, label: {
                            Text("OK")
                        })
                        .padding(10)
                    }//end HStack
                        .background(Color(UIColor.darkGray))
                        .foregroundColor(Color.white)
                    Text("Enter aircraft info:")
                        .font(.callout)
                        .padding(.leading,10)
                    List{
                        HStack {
                            Button(action: {
                                self.aircraftData.presentAircraftList = true
                            }, label: {
                                Text("Select Aircraft")
                            })
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.orange))
                            
                            Divider()
                            TextField("Aircraft", text: $aircraftData.selectedAircraft)
                                .multilineTextAlignment(.center)
                        }
                        .font(.title2)
                        
                        HStack{
                            Text("    Basic Weight:")
                                .frame(width: 160, height: 50)
                                .multilineTextAlignment(.trailing)
                            Divider()
                            NumberTextField(value: $aircraftData.basicWeight, maxValue: 75000)
                        }
                        .font(.title2)
                        HStack {
                            Text("Aircraft Moment:")
                                .frame(width: 160, height: 50)
                                .multilineTextAlignment(.trailing)
                            Divider()
                            DoubleTextField(value: $aircraftData.aircraftMoment, maxValue: 37000.0)
                        }
                        .font(.title2)
                    }
                }//end VStack
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(width: 400, height: 280)
                .padding(.horizontal, 10)
                .padding(.top, 20)
                Spacer()
            }//end VStack
            .popover(isPresented: $aircraftData.presentAircraftList, attachmentAnchor: .point(.top), content: {
                if aircraftData.showLrtList {
                    AircraftListView(aircraftList: lrtList)
                }else {
                    AircraftListView(aircraftList: aewList)
                }
            })
            if aircraftData.presentAircraftList {
                
            }
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    
    }
}

struct AircraftUserInfo_Previews: PreviewProvider {
    
    static var previews: some View {
        let aircraftData = AircraftData()
        return AircraftUserInfo().environmentObject(aircraftData)
    }
}
