//
//  SavedDataView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/24/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct SavedDataView: View {
    @State private var showEditAlert = false
    @State private var showDeleteAlert = false
    
    //Core Data setup:
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors:
                    [NSSortDescriptor(keyPath: \SavedWeight.date, ascending: true),
                     NSSortDescriptor(keyPath: \SavedWeight.aircraft, ascending: true)
                    ])
    var weights: FetchedResults<SavedWeight>
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        
        List {
            Section(header:
                        EditButton().frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .overlay(Text("Saved Profiles").font(.title2), alignment: .center).padding()) {
                ForEach(weights) {weight in
                    HStack{
                        Group {
                            Text(dateFormatter.string(from: weight.date!))
                            Divider()
                            Text(weight.aircraft ?? "")
                            Divider()
                            Text("Gross Weight: \(weight.grossWeight ?? "")")
                                .frame(width: 150, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                //.fixedSize(horizontal: false, vertical: true)
                                .lineLimit(nil)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            Divider()
                            Text(" CG: \(weight.cg ?? "")")
                                .frame(width: 75, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            Divider()
                            Text("Profile: \(weight.missionType ?? "N/A")")
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .border(Color.black, width: 1)
                                .lineLimit(nil)
                        }
                        
                        Group {
                            HStack {
                                Divider()
                                Button(action: {
                                    self.showEditAlert.toggle()
                                }, label: {
                                    Text("Use")
                                })
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 6.0)
                                            .stroke(Color.yellow, lineWidth: 3))
                                .alert(isPresented: $showEditAlert, content: {
                                    Alert(title: Text("Edit"),
                                          message: Text("Are you sure you want to EDIT this profile?"),
                                          primaryButton: .default(Text("OK")){
                                            //action to perform here
                                          },
                                          secondaryButton: .cancel())
                                })
                            }//end HStack
                        }//end Group
                    }//end HStack
                    .padding()
                    .font(.title3)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                    .frame(width: 700, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }//end for each
                .onDelete(perform: deleteWeight)
            }
            
        }//end List
        .listStyle(InsetGroupedListStyle())
    }//end view
    
    private func saveContext(){
        do {
            try viewContext.save()
        }catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }//end saveContent
    
    private func deleteWeight(offsets: IndexSet) {
        withAnimation {
            offsets.map { weights[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }//end deleteWeight
}//end struct

struct SavedDataView_Previews: PreviewProvider {
    static var previews: some View {
        SavedDataView()
    }
}
