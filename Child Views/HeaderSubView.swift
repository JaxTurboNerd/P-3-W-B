//
//  HeaderSubView.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 9/17/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct HeaderSubView: View {
    var label:String
    var weight:String
    
    var body: some View {
        ZStack {
            Rectangle()
                .colorInvert()
                .border(Color.gray, width: 2)
                .shadow(color: .gray, radius: 4, y: 4)
                .frame(width: 160.0, height: 85.0)
                .overlay(weightView)
        }//end ZStack
    }//end some view
    
    var weightView: some View {
        VStack(alignment: .center) {
            Text(label)
                .frame(width: 150.0)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
            Divider()
            Text("\(weight)")
                .frame(width: 90.0)
                .multilineTextAlignment(.center)
        }//end VStack
    }//end weightView
}

struct HeaderSubView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSubView(label: "Basic Weight", weight: "00000")
    }
}
