//
//  ButtonView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 9/20/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject var aircraftData: AircraftData
    
    //Core Data connection setup:
    @Environment(\.managedObjectContext) var viewContext
    
    //variables for the alerts;
    enum ActiveAlert {
        case error, save
    }
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .save
    @State private var showResetAlert = false
    
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
                        self.activeAlert = .error
                    }else {
                        saveWeight()
                        self.activeAlert = .save
                    }//end if-else
                    self.showAlert.toggle()
                }) {
                    Text("Save")
                }
                .padding()
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                .foregroundColor(.black)
                .alert(isPresented: $showAlert) {
                    switch activeAlert {
                    case .error:
                        return Alert(title: Text("Incorrect Aircraft Selection"),message: Text("Please select the opposite aircraft type (LRT/AEW)"), dismissButton: .default(Text("OK")))
            
                    case .save:
                        return Alert(title: Text("Saved Data"), message: Text("Aircraft data saved"), dismissButton: .default(Text("OK")))
                    }//end switch
                }//end alert
                Spacer()
            }//end HStack
        }//end VStack
        .padding(.bottom)
    }//end body
}//end struct

/*
 The functions used to save and to determine if there is a view mis-match are contained in the
 SaveFunctions extension file
 */


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
