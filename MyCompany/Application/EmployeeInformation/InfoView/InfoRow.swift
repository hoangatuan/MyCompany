//
//  InfoRow.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/11/20.
//

import SwiftUI

enum EditStyle {
    case none
    case text
    case number
    case date
    case dropdown
}

struct InfoRow: View {
    @ObservedObject private var data: EmployeePresentData = EmployeePresentData(title: "Gender", content: "Male")
    @State private var isShowTextField: Bool = false
    @State private var inputText: String = ""
    @State private var selectedDate: Date = Date()
    @State private var jobRank: String = ""
    private var jobRankValues: [String] = ["DEV 1", "DEV 2", "DEV 3",
                                           "TEST 1", "TEST 2", "TEST 3",
                                           "PM 1", "PM 2", "PM 3", "SA 1", "SA2", "SA3"]
    
    init(data: EmployeePresentData) {
        self.data = data
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                Text(data.title)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            
            HStack {
                if isShowTextField {
                    if data.editStyle == .number || data.editStyle == .text {
                        let keyboardType: UIKeyboardType = data.editStyle == .number ? .numberPad : .default
                        
                        CustomTextField(inputText: $inputText, currentText: data.content, keyboardType: keyboardType, placeHolder: "", isAutoShowKeyboard: true, onCompleteEditing: { value in
                            if !value.trimmingCharacters(in: .whitespaces).isEmpty {
                                data.content = value
                            }
                            isShowTextField = false
                        })
                        .padding(.init(top: 4, leading: 8, bottom:4 , trailing: 8))
                        .background(Color(UIColor.ColorE9E9E9))
                        .cornerRadius(10.0)
                    } else if data.editStyle == .date {
                        DatePickerView(date: $selectedDate, dateDidChange: {}, isIgnoreFirstTime: true, onComplete: {
                            data.content = selectedDate.convertToFormat(format: .iso)
                            isShowTextField = false
                        })
                    } else if data.editStyle == .dropdown {
                        DropdownButton(defaultValue: $jobRank, title: "Select Job Rank", values: jobRankValues)
                    }
                } else {
                    Text(data.content)
                        .bold()
                        .font(.title3)
                    Spacer()
                    
                    if UserDataDefaults.shared.isAdministrator {
                        Button(action: {
                            isShowTextField = true
                        }, label: {
                            Image("icon_request_edit")
                                .resizable().frame(width: 32, height: 32, alignment: .center)
                                .padding(.horizontal, 8)
                        })
                    }
                }
            }.onAppear(perform: {
                jobRank = data.content
            }).onChange(of: jobRank, perform: { value in
                isShowTextField = false
                data.content = value
            })
            
            Divider()
        }).padding([.leading, .trailing])
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(data: EmployeePresentData(title: "Gender", content: "Male"))
            .previewLayout(.sizeThatFits)
    }
}
