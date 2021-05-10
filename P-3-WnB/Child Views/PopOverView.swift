//
//  PopOverView.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 5/9/21.
//
//*************** NOT USED **************************************
import SwiftUI

struct PopOverView: View {
    @EnvironmentObject private var aircraftData: AircraftData
    @State private var showSaveAlert = false
    
    //Picker setup:
    @State var pickerSelection: String = "Mission"
    let missionTypes: [String] = ["Mission", "Transit", "Training", "Other"]
    
    //Core Data setup:
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Picker(selection: $pickerSelection,
                   label:
                    HStack {
                        Text("Mission Type:")
                        Text(pickerSelection)
                    }
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3),
                            radius: 10, x: 0, y: 10)
                   ,
                   content: {
                    ForEach(missionTypes, id: \.self, content: {option in
                        Text(option)
                            .tag(option)
                            
                    })
            })
                .pickerStyle(MenuPickerStyle())
            
            Spacer()
            
            HStack(spacing: 40) {
                Button("Save"){
                    saveWeight()
                    //need to dismiss the calling popover view
                    self.showSaveAlert.toggle()
                }
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color.green)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3),
                        radius: 10, x: 0, y: 10)
                
                .alert(isPresented: $showSaveAlert) {
                    Alert(title: Text("Saved Data"),
                          message: Text("Aircraft data saved!"),
                          
                          dismissButton: .default(Text("OK")))
                }//end alert
                
                Button("Dismiss"){
                    self.presentation.wrappedValue.dismiss()
                }
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color.red)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3),
                        radius: 10, x: 0, y: 10)
                
            }//end HStack
            Spacer()
        }//end VStack
        .padding()
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
}

struct PopOverView_Previews: PreviewProvider {
    static var previews: some View {
        PopOverView()
    }
}
