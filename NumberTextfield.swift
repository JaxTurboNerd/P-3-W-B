//
//  NumberTextfield.swift
//  W&BSwiftUI
//
//  Created by Gregory Boyd on 10/25/20.
//  Copyright © 2020 Gregory Boyd. All rights reserved.
//

import SwiftUI

struct NumberTextField<V>: UIViewRepresentable where V: Numeric & LosslessStringConvertible {
    @Binding var value: V
    var maxValue: Int
    
    typealias UIViewType = UITextField

    func makeUIView(context: UIViewRepresentableContext<NumberTextField>) -> UITextField {
        let editField = UITextField()
        editField.delegate = context.coordinator
        return editField
    }

    func updateUIView(_ editField: UITextField, context: UIViewRepresentableContext<NumberTextField>) {
        editField.text = String(value)
        editField.textAlignment = .center
        editField.keyboardType = .numberPad
    }

    func makeCoordinator() -> NumberTextField.Coordinator {
        //create instance of class Coordinator:
        Coordinator(value: $value, maxValue: maxValue)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var value: Binding<V>
        var maxValue: Int
        
        init(value: Binding<V>, maxValue: Int) {
            self.value = value
            self.maxValue = maxValue
        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            textField.backgroundColor = UIColor.cyan.withAlphaComponent(0.2)
            textField.borderStyle = .bezel
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {

            let text = textField.text as NSString?
            
            let newValue = text?.replacingCharacters(in: range, with: string)
                        
            if let number = V(newValue ?? "0") {
                self.value.wrappedValue = number
                return true
            } else {
                if nil == newValue || newValue!.isEmpty {
                    self.value.wrappedValue = 0
                }
                return false
            }
        }
        
        //validate maximum values entered by user:
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            let textValue = Int(textField.text!)
            if(textValue! > maxValue){
                textField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
                return false
            }
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            if reason == .committed {
                textField.backgroundColor = UIColor.clear
                textField.borderStyle = .none
                textField.resignFirstResponder()
            }
        }
    }
}
