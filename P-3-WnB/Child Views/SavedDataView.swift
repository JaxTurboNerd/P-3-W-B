//
//  SavedDataView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/24/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct SavedDataView: View {
    //Core Data setup:
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors:
        [NSSortDescriptor(keyPath: \SavedWeight.date, ascending: true),
        NSSortDescriptor(keyPath: \SavedWeight.aircraft, ascending: true)
        ])
    var weights: FetchedResults<SavedWeight>
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        List {
            ForEach(weights) {weight in
                HStack{
                    Spacer()
                    Text(dateFormatter.string(from: weight.date!))
                    Divider()
                    Text(weight.aircraft ?? "Not Saved")
                    Divider()
                    Text(weight.grossWeight ?? "Not Saved")
                    Divider()
                    Text(weight.cg ?? "Not Saved")
                    Button(action: {
                        
                    }, label: {
                        Text("Edit")
                    })
                    Spacer()
                }
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                .frame(width: 700, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }//end for each
            .onDelete(perform: deleteWeight)
        }//end List
    }//end view
    
    private func saveContext(){
        do {
            try viewContext.save()
        }catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    private func deleteWeight(offsets: IndexSet) {
        withAnimation {
            offsets.map { weights[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }
}//end struct

struct SavedDataView_Previews: PreviewProvider {
    static var previews: some View {
        SavedDataView()
    }
}
