//
//  VertInputView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/25/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct VertInputView: View {
    var label:String
    var maxWeight: Int
    var maxChars: Int
    @Binding var weight: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .colorInvert()
                .border(Color.gray, width: 2)
                .frame(width: 110.0, height: 90.0)
                .overlay(weightView)
        }//end ZStack
    }//end some view
    
    var weightView: some View {
        VStack() {
            Text(label)
                .frame(width: 110.0)
                .fixedSize(horizontal: false, vertical: true)
            Divider()
            NumberTextField(value: $weight, maxValue: maxWeight, maxChars: maxChars)
                .frame(width: 90, height: 35)
        }//end VStack
    }//end weightView
}//end struct

struct VertInputView_Previews: PreviewProvider {
    static var previews: some View {
        VertInputView(label: "Fuel", maxWeight: 0, maxChars: 3, weight: Binding.constant(000))
    }
}
