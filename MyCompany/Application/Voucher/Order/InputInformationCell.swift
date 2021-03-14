//
//  InputInformationCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import SwiftUI

struct InputInformationCell: View {
    @Binding var inputText: String
    var title: String
    var placeholder: String
    var imageName: String
    var isDisableEditing: Bool
    var isNumberInput: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(Font.system(size: 14))
            HStack {
                if isNumberInput {
                    CustomTextField(inputText: $inputText, currentText: "", keyboardType: .numberPad, placeHolder: placeholder, isAutoShowKeyboard: false) { (_) in

                    }
                    .frame(height: 22, alignment: .center)
                } else {
                    TextField(placeholder, text: $inputText)
                    Spacer()
                }
                
                Image(imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(Color.gray, lineWidth: 2.0))
        .background(isDisableEditing ? Color(UIColor.ColorE9E9E9) : Color.clear)
        .disabled(isDisableEditing)
    }
}

struct InputInformationCell_Previews: PreviewProvider {
    static var previews: some View {
        InputInformationCell(inputText: .constant(""), title: "Ho ten", placeholder: "Placeholder",
                             imageName: "icon_menu_setting", isDisableEditing: true)
            .previewLayout(.sizeThatFits)
    }
}
