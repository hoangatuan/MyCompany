//
//  CoinCustomTextfieldView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/8/20.
//

import SwiftUI

struct CoinCustomTextfieldView: UIViewRepresentable {
    @Binding var inputText: String
    var textAlignment: NSTextAlignment
    var coinType: CoinType
    var onTextDidChange: ((Int) -> Void)
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onTextDidChange: (Int) -> Void
        var currentText: String = "0"
        var coinType: CoinType
        
        init(text: Binding<String>, coinType: CoinType, action: @escaping (Int) -> Void) {
            _text = text
            onTextDidChange = action
            self.coinType = coinType
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.text = currentText
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "" { // Delete
                currentText.removeLast()
                self.text = currentText
                onTextDidChange(Int(currentText) ?? 0)
                textField.text = Converter.formatNumberToReadableMoney(num: currentText)
                
                return false
            } else {
                let processedInput = preprocessInput(string: string)
                textField.text = Converter.formatNumberToReadableMoney(num: processedInput)
                onTextDidChange(Int(processedInput) ?? 0)
                currentText = processedInput
                self.text = currentText
                
                return false
            }
        }
        
        private func preprocessInput(string: String) -> String {
            let maxValue = coinType == .exchange ? Constants.maximumExchangeCoin : Constants.maximumPaymentCoin
            let newString = currentText + string
            let numberValue = Int(newString) ?? 0
            if numberValue >= maxValue {
                return String(maxValue)
            } else {
                return String(numberValue)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $inputText, coinType: coinType, action: onTextDidChange)
    }
    
    func makeUIView(context: UIViewRepresentableContext<CoinCustomTextfieldView>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = .numberPad
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
        toolBar.items = [space, doneButton]
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        
        textField.text = inputText
        textField.font = UIFont.systemFont(ofSize: 28)
        textField.textColor = UIColor.black
        
        textField.delegate = context.coordinator
        textField.textAlignment = textAlignment
        textField.returnKeyType = UIReturnKeyType.done
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CoinCustomTextfieldView>) {
        context.coordinator.currentText = inputText
        uiView.text = Converter.formatNumberToReadableMoney(num: inputText) 
    }
}

struct CoinCustomTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        CoinCustomTextfieldView(inputText: .constant("0"), textAlignment: .center, coinType: .exchange, onTextDidChange: { value in})
    }
}
