//
//  ContentView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 7/31/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.s
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    @State private var selected = 0
    @State private var showAlert = false
    
    var body: some View {
        
        TabView(selection: $selected){
            LRTView().tabItem({
                Image(systemName: "airplane")
                Text("LRT")
            }).tag(0)
//            .onAppear(){
//                //show AlERT if selectedAircraft != selectedLRT
//                if aircraftData.alertTrigger && !aircraftData.aircraftIsLRT {
//                    self.showAlert = true
//                }//end if
//            }//end onAppear
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Aircraft Selection"), message: Text("Check Aircraft Selection"), dismissButton: .cancel())
            })
            AEWView().tabItem({
                Image(systemName: "circle.fill")
                Text("AEW")
            }).tag(1)
//            .onAppear(){
//                if aircraftData.alertTrigger && aircraftData.aircraftIsLRT {
//                    self.showAlert = true
//                }//end if
//            }//end onAppear
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Aircraft Selection"), message: Text("Check Aircraft Selection"), dismissButton: .cancel())
            })
            SavedDataView().tabItem({
                Image(systemName: "heart.fill")
                Text("Saved")
            }).tag(2)
        }//end Tab View
    }//end some View
}//end struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let aircraftData = AircraftData()
        return ContentView().environmentObject(aircraftData)
    }
}
