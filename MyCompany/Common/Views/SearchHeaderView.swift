//
//  SearchHeaderView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/17/20.
//

import SwiftUI

struct SearchHeaderView: View {
    @Binding var newType: Int
    @Binding var searchTitle: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let placeHolder: String
    let valuesArray: [String]
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 16, height: 20)
                    }).frame(width: 32, height: 32)
                    .foregroundColor(.black)
                    
                    SearchBar(inputText: $searchTitle, placeHolder: placeHolder, isWhiteBackground: false)
                }
                
                Picker("", selection: $newType, content: {
                    ForEach(0 ..< valuesArray.count) {
                        Text(valuesArray[$0])
                    }
                }).pickerStyle(SegmentedPickerStyle())
            }.padding()
            
            Divider()
                .background(Color.white.shadow(color: Color.gray, radius: 2, x: 0, y: 1)) // Way to set shadow not impact child view
        }
    }
}

struct SearchHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHeaderView(newType: .constant(0), searchTitle: .constant(""), placeHolder: "Type title...", valuesArray: ["News", "Announcements"])
    }
}
