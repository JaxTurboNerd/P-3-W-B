//
//  InputView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 8/25/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI
import Combine

struct HorizontalInputView: View {
    var label:String
    var maxWeight: Int
    var maxChars: Int
    @Binding var weight: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .colorInvert()
                .border(Color.gray, width: 2)
                .frame(width: 230.0, height: 35.0)
                .overlay(weightView)
        }//end ZStack
    }//end some view
    
    var weightView: some View {
        HStack {
            Text(label)
                .frame(width: 160.0)
            //Divider()
            NumberTextField(value: $weight, maxValue: maxWeight, maxChars: maxChars)
        }//end HStack
    }//end weightView
}//end struct

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalInputView(label: "Pilot: ", maxWeight: 0, maxChars: 3, weight: Binding.constant(000))
    }
}
