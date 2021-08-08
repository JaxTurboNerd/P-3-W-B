//
//  MomentTextField.swift
//  P-3-WnB
//
//  Created by Gregory Boyd on 8/8/21.
//

import SwiftUI

struct MomentTextField<V>: UIViewRepresentable where V: LosslessStringConvertible {
    @Binding var value: V
    var maxValue: Double
    var maxChars: Int
    
    typealias UIViewType = UITextField

    func makeUIView(context: UIViewRepresentableContext<MomentTextField>) -> UITextField {
        let editField = UITextField()
        editField.delegate = context.coordinator
        return editField
    }

    func updateUIView(_ editField: UITextField, context: UIViewRepresentableContext<MomentTextField>) {
        editField.text = String(value)
        editField.textAlignment = .center
        editField.keyboardType = .numberPad
    }

    func makeCoordinator() -> MomentTextField.Coordinator {
        //create instance of class Coordinator:
        Coordinator(value: $value, maxValue: maxValue, maxChars: maxChars)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var value: Binding<V>
        var maxValue: Double
        var maxChars: Int
        
        init(value: Binding<V>, maxValue: Double, maxChars: Int) {
            self.value = value
            self.maxValue = maxValue
            self.maxChars = maxChars
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
            
            //code to limit the user's maximum character
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            //code to set the allowed characters to be entered by the user:
            let charactersAllowed = CharacterSet(charactersIn: ".0123456789")
            //let rangeOfCharacters = string.rangeOfCharacter(from: charactersAllowed, options: .caseInsensitive)
                    
            if let rangeOfCharactersAllowed = string.rangeOfCharacter(from: charactersAllowed) {
                self.value.wrappedValue = rangeOfCharactersAllowed as! V
                return newLength <= maxChars
            } else {
                if nil == newValue || newValue!.isEmpty {
                    self.value.wrappedValue = 0 as! V
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
