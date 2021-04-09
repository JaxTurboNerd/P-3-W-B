//
//  SavedDataView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/24/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct SavedDataView: View {
    
    //variables to hold user default data:
    private var savedAircraft = UserDefaults.standard.value(forKey: "selectedAircraft") as? String
    private var savedBW = UserDefaults.standard.value(forKey: "basicWeight") as? String
    private var savedGW = UserDefaults.standard.value(forKey: "grossWeight") as? String
    private var savedCG = UserDefaults.standard.value(forKey: "cg") as? String
    private var savedZFW = UserDefaults.standard.value(forKey: "zfw") as? String
    private var savedDate = UserDefaults.standard.value(forKey: "savedDate") as? String
   
    var body: some View {
        VStack {
            Text("Saved Data View")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            Divider()
            Spacer()
            VStack(spacing: 20.0){
                Text("\(savedAircraft ?? "XXXSK") Weight & Balance")
                    .font(.largeTitle)
                Text(savedDate ?? "mm/dd/yyyy")
                    .font(.title)
                Divider()
                HStack{
                    Spacer()
                    HeaderSubView(label: "Basic Weight", weight: savedBW ?? "xxxxx")
                    Spacer()
                    HeaderSubView(label: "ZFW", weight: savedZFW ?? "xxxxx")
                    Spacer()
                    HeaderSubView(label: "Gross Weight", weight: savedGW ?? "xxxxx")
                    Spacer()
                    HeaderSubView(label: "C.G.", weight: savedCG ?? "xx.x")
                    Spacer()
                }//end HStack
                Spacer()
            }//end VStack
        }//end VStack
    }//end view
}//end struct

struct SavedDataView_Previews: PreviewProvider {
    static var previews: some View {
        SavedDataView()
    }
}
