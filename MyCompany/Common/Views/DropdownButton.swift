//
//  DropdownButton.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/4/20.
//

import SwiftUI

struct DropdownButton: View {
    @State private var showingActionSheet = false
    @Binding var defaultValue: String
    
    var title: String
    var values: [String]
    
    var body: some View {
        HStack {
            LeadingText(text: defaultValue)
            Button(action: {
                showingActionSheet = true
            }, label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 17.5, height: 10)
            })
        }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(Color.gray, lineWidth: 2.0))
        .actionSheet(isPresented: $showingActionSheet, content: {
            self.generateActionSheet(options: values)
        }).accentColor(Color(UIColor.ColorFF88A7))
    }
    
    func generateActionSheet(options: [String]) -> ActionSheet {
        let buttons = options.map { option in
            Alert.Button.default(Text(option), action: { self.defaultValue = option } )
        }
        return ActionSheet(title: Text(title),
                   buttons: buttons + [Alert.Button.cancel()])
    }
}

struct DropdownButton_Previews: PreviewProvider {
    static var previews: some View {
        DropdownButton(defaultValue: .constant("FPT Cau Giay, FHN"), title: "Select Location", values: [])
            .previewLayout(.sizeThatFits)
    }
}
