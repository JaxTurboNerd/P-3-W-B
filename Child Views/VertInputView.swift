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
    @Binding var weight: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .colorInvert()
                .border(Color.gray, width: 2)
                .shadow(color: .gray, radius: 4, y: 4)
                .frame(width: 110.0, height: 85.0)
                .overlay(weightView)
        }//end ZStack
    }//end some view
    
    var weightView: some View {
        VStack(alignment: .center) {
            Text(label)
                .frame(width: 110.0)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            Divider()
            NumberTextField(value: $weight, maxValue: maxWeight)
                .frame(width: 90, height: 35)
        }//end VStack
    }//end weightView
}//end struct

struct VertInputView_Previews: PreviewProvider {
    static var previews: some View {
        VertInputView(label: "Fuel", maxWeight: 0, weight: Binding.constant(000))
    }
}
