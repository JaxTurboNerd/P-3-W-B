//
//  ButtonView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 9/20/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    
    //Core Data connection setup:
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showResetAlert = false
    @State private var showSavedAlert = false
    @State private var mismatchAlert = false
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    self.showResetAlert.toggle()
                }) {
                    Text("Reset")
                }
                .padding()
                .padding(.horizontal)
                .foregroundColor(.red)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                .alert(isPresented: $showResetAlert, content: {
                    Alert(
                        title: Text("Delete"),
                        message: Text("Are you sure you want to delete ALL values?"),
                        primaryButton: .default(Text("OK")){
                            aircraftData.resetFuelWeights()
                            aircraftData.resetCargoWeights()
                            aircraftData.resetPositionWeights()
                        },
                        secondaryButton: .cancel())
                    
                })
                Spacer()
                Button(action: {
                    determineViewMismatch()
                    if self.aircraftData.aircraftViewMismatch {
                        self.mismatchAlert.toggle()
                    }else {
                        saveWeight()
                        self.showSavedAlert.toggle()
                    }//end if-else
                }) {
                    Text("Save")
                }
                .padding()
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                .foregroundColor(.black)
                .alert(isPresented: $showSavedAlert) {
                    Alert(title: Text("Saved Data"),
                          message: Text("Aircraft data saved!"),
                          
                          dismissButton: .default(Text("OK")))
                }//end alert
                .alert(isPresented: $mismatchAlert) {
                    Alert(title: Text("Incorrect Aircraft Selection"),
                          message: Text("Please select the appropriate aircraft type (LRT/AEW)"),
                          
                          dismissButton: .default(Text("OK")))
                }//end alert
                Spacer()
            }//end HStack
        }//end VStack
        .padding(.bottom)
    }//end body
    
    private func saveWeight(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let newWeight = SavedWeight(context: viewContext)
        newWeight.date = Date()
        
        //check for empty selected aircraft:
        guard aircraftData.selectedAircraft != "" else {
            newWeight.aircraft = "NXXXSK"
            return
        }
        newWeight.aircraft = aircraftData.selectedAircraft
        newWeight.cg = aircraftData.cg
        newWeight.grossWeight = aircraftData.grossWeight
        newWeight.zfw = aircraftData.ZFW
        newWeight.missionType = aircraftData.missionType
        
        do {
            try viewContext.save()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error.localizedDescription)")
        }//end try-catch
    }//end saveWeight function
    
    //This function determines if the user has an LRT selected while on the AEW view and tries to save the existing data...or vice versa (AEW selected while on the LRT View
    private func determineViewMismatch(){
        //On the LRT tab with an AEW aircraft selected:
        if (self.aircraftData.viewSelected == 0 && !self.aircraftData.aircraftIsLRT){
            self.aircraftData.aircraftViewMismatch = true
        } else if
            //On the AEW tab with an LRT aircraft selected:
            (self.aircraftData.viewSelected == 1 && self.aircraftData.aircraftIsLRT){
            self.aircraftData.aircraftViewMismatch = true
        } else {
            self.aircraftData.aircraftViewMismatch = false
        }
    }//end func
}//end struct


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
