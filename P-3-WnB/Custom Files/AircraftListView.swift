//
//  AircraftListView.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 7/20/21.
//

import SwiftUI

struct AircraftListView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    let aircraftList: [String]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            VStack {
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Button(action: {//Cancel button
                            withAnimation{
                                self.aircraftData.presentAircraftList = false
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
                                    self.aircraftData.presentAircraftList = false
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

struct AircraftListView_Previews: PreviewProvider {
    static let sampleData = ["N403SK", "N480SK", "N741SK", "N769SK"]
    static var previews: some View {
        AircraftListView(aircraftList: sampleData)
    }
}
