//
//  CustomTextField.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/29/20.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    @Binding var inputText: String
    var currentText: String
    var keyboardType: UIKeyboardType
    var placeHolder: String
    var isAutoShowKeyboard: Bool
    
    var onCompleteEditing: ((String) -> Void)
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onCompleteEditing: (String) -> Void
        
        
        init(text: Binding<String>, action: @escaping (String) -> Void) {
            _text = text
            onCompleteEditing = action
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            onCompleteEditing(textField.text ?? "")
            return true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $inputText, action: onCompleteEditing)
    }
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = keyboardType
        
        if keyboardType == .numberPad {
            UITextField.onDoneNumPad = onCompleteEditing
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
            toolBar.items = [space, doneButton]
            toolBar.sizeToFit()
            textField.inputAccessoryView = toolBar
        }
        
        textField.text = currentText
        textField.textColor = UIColor.black
        textField.placeholder = placeHolder
        
        if isAutoShowKeyboard {
            textField.becomeFirstResponder()
        }
        
        textField.delegate = context.coordinator
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = inputText
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(inputText: .constant(""), currentText: "DEF", keyboardType: .default, placeHolder: "", isAutoShowKeyboard: false, onCompleteEditing: {_ in })
    }
}

extension UITextField {
    static var onDoneNumPad: ((String) -> Void)?
    
    // Default actions:
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
        UITextField.onDoneNumPad?(self.text ?? "")
        self.resignFirstResponder()
    }
}
