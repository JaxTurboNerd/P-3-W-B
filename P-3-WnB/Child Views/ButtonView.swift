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
    @State var showPopOver = false
    
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
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                .foregroundColor(.red)
                .alert(isPresented: $showResetAlert, content: {
                    Alert(title: Text("Delete"), message: Text("Are you sure you want to delete ALL values?"),
                          primaryButton: .default(Text("OK")){
                            aircraftData.resetFuelWeights()
                            aircraftData.resetCargoWeights()
                            aircraftData.resetPositionWeights()
                          },
                          secondaryButton: .cancel())
                    
                })
                Spacer()
                Button(action: {
                    self.showPopOver.toggle()
                }) {
                    Text("Save")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                .foregroundColor(.black)
                .sheet(isPresented: $showPopOver, content: {
                    PopOverView()
                    //SavePopOver()
                })
                Spacer()
            }//end HStack
        }//end VStack
        .padding(.bottom)
    }//end body
}//end struct

//struct SavePopOver: View {
//    @EnvironmentObject private var aircraftData: AircraftData
//    @State private var showSaveAlert = false
//    
//    //Core Data setup:
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @Environment(\.presentationMode) var presentation
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Choose the type of mission:")
//            Text("Mission Profile")
//            Text("Transit Profile")
//            Text("Training Profile")
//            Text("Other")
//            HStack(spacing: 40) {
//                Button("Save"){
//                    saveWeight()
//                    //need to dismiss the calling popover view
//                    self.showSaveAlert.toggle()
//                }
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                .padding()
//                .alert(isPresented: $showSaveAlert) {
//                    Alert(title: Text("Saved Data"),
//                          message: Text("Aircraft data saved!"),
//                          
//                          dismissButton: .default(Text("OK")))
//                }//end alert
//                
//                Button("Dismiss"){
//                    self.presentation.wrappedValue.dismiss()
//                }
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                .padding()
//            }
//        }//end VStack
//    }//end body
//    
//    private func saveWeight(){
//        let newWeight = SavedWeight(context: viewContext)
//        newWeight.date = Date()
//        newWeight.aircraft = aircraftData.selectedAircraft
//        newWeight.cg = aircraftData.cg
//        newWeight.grossWeight = aircraftData.grossWeight
//        newWeight.zfw = aircraftData.ZFW
//        newWeight.missionType = aircraftData.missionType
//        
//        do {
//            try viewContext.save()
//        }catch {
//            let error = error as NSError
//            fatalError("Unresolved error: \(error.localizedDescription)")
//        }//end try-catch
//    }//end saveWeight function
//}//end struct

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
