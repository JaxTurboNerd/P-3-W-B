//
//  DoubleTextfield.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 7/20/21.
//

import SwiftUI

struct DoubleTextField<V>: UIViewRepresentable where V: Numeric & LosslessStringConvertible {
    @Binding var value: V
    var maxValue: Double
    
    typealias UIViewType = UITextField

    func makeUIView(context: UIViewRepresentableContext<DoubleTextField>) -> UITextField {
        let editField = UITextField()
        editField.delegate = context.coordinator
        return editField
    }

    func updateUIView(_ editField: UITextField, context: UIViewRepresentableContext<DoubleTextField>) {
        editField.text = String(value)
        editField.textAlignment = .center
        editField.keyboardType = .numberPad
    }

    func makeCoordinator() -> DoubleTextField.Coordinator {
        //create instance of class Coordinator:
        Coordinator(value: $value, maxValue: maxValue)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var value: Binding<V>
        var maxValue: Double
        
        init(value: Binding<V>, maxValue: Double) {
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
            
            //let maxLength = 7
            let text = textField.text as NSString?
            let newValue = text?.replacingCharacters(in: range, with: string)
                        
            if let number = V(newValue ?? "0") {
                self.value.wrappedValue = number
                return true
                //return newValue.length <= maxLength
            } else {
                if nil == newValue || newValue!.isEmpty {
                    self.value.wrappedValue = 0
                }
                return false
            }
        }
        
        //validate maximum values entered by user:
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            let textValue = Double(textField.text!)
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

