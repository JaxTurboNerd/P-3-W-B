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
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    aircraftData.resetFuelWeights()
                    aircraftData.resetCargoWeights()
                    aircraftData.resetPositionWeights()
                }) {
                               Text("Reset")
                           }
                           .padding()
                           .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                           .foregroundColor(.red)
                Spacer()
                Button(action: {
                    aircraftData.saveWeights()
                    self.showAlert.toggle()
                }) {
                    Text("Save")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                .foregroundColor(.black)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Saved Data"), message: Text("Aircraft data saved!"), dismissButton: .default(Text("OK")))
                }
                Spacer()
            }
            
        }//end VStack
    }
    
    private func saveWeight(){
        let newWeight = SavedWeight(context: viewContext)
        newWeight.date = Date()
        newWeight.aircraft = aircraftData.selectedAircraft
        newWeight.cg = aircraftData.cg
        newWeight.grossWeight = aircraftData.grossWeight
        newWeight.zfw = aircraftData.ZFW
        
        do {
            try viewContext.save()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
