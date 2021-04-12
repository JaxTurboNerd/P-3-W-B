//
//  SavedDataView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/24/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct SavedDataView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var weights: FetchedResults<SavedWeight>
    
    var body: some View {
        ScrollView {
            ForEach(weights) {weight in
                Text(weight.aircraft ?? "No Aircraft")
            }
        }
    }//end view
}//end struct

struct SavedDataView_Previews: PreviewProvider {
    static var previews: some View {
        SavedDataView()
    }
}
