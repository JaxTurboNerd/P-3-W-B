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
                    saveWeight()
                    self.showSavedAlert.toggle()
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
                Spacer()
            }//end HStack
        }//end VStack
        .padding(.bottom)
    }//end body
    
    private func saveWeight(){
        let newWeight = SavedWeight(context: viewContext)
        newWeight.date = Date()
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
}//end struct


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
