//
//  CreateRequestView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/10/20.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button
}

struct CreateRequestView: View {
    @State private var requestType: String = "Chọn loại đơn..."
    @State private var partialDay: String = "Cả ngày"
    @State private var reason: String = "Chọn lí do..."
    @State private var reasonDetail: String = ""
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var showMyRequest: Bool = false
    
    @ObservedObject var viewModel: CreateRequestViewModel
    
    init() {
        viewModel = CreateRequestViewModel()
    }
    
    var body: some View {
        VStack {
            CustomRightActionNavBar(navBarTitle: "Create New Request", isShowBackButton: false, rightButtonTitle: "My Request", actionRightButton: {
                showMyRequest = true
            })
            
            NavigationLink(
                destination: AllRequestsView(),
                isActive: $showMyRequest,
                label: {
                    
                })
            
            ScrollView {
                Group {
                    
                    LeadingText(text: "Request Type*")
                    DropdownButton(defaultValue: $requestType, title: "Chọn loại đơn...", values: viewModel.requestType)
                    
                    LeadingText(text: "Start Date*")
                    HStack {
                        DatePickerView(date: $startDate, dateDidChange: {
                            if startDate > endDate {
                                endDate = startDate
                            }
                        })
                        Spacer()
                    }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.gray, lineWidth: 2.0))
                    
                    LeadingText(text: "End Date*")
                    HStack {
                        DatePickerView(date: $endDate, dateDidChange: {
                            if endDate < startDate {
                                startDate = endDate
                            }
                        })
                        Spacer()
                    }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.gray, lineWidth: 2.0))
                    
                    LeadingText(text: "Partial Day*")
                    DropdownButton(defaultValue: $partialDay, title: "", values: viewModel.partialDay)
                    
                    LeadingText(text: "Reason*")
                }.padding([.leading, .trailing])
                
                Group {
                    DropdownButton(defaultValue: $reason, title: "", values: viewModel.reason)
                    LeadingText(text: "Reason Detail")
                    TextField("Reason Detail...", text: $reasonDetail)
                        .padding(EdgeInsets(top: 10.0, leading: 4.0, bottom: 10.0, trailing: 4.0))
                        .border(Color.black)
                }.padding([.leading, .trailing])
                
                Button(action: {
                    viewModel.createNewRequest(requestType: requestType,
                                               startDate: startDate.convertToFormat(format: .iso),
                                               endDate: endDate.convertToFormat(format: .iso),
                                               partialDay: partialDay, reason: reason, reasonDetail: reasonDetail)
                }, label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                }).frame(width: UIScreen.main.bounds.width - 32)
                .background(Color(UIColor.ColorFF88A7))
                .cornerRadius(30.0)
                .padding()
            }.padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            .alert(isPresented: $viewModel.onShowAlert, content: {
                // Can not create 2 alert because last alert will override all before alerts.
                switch viewModel.response {
                    case .invalidateInput:
                        return Alert(title: Text(viewModel.invalidInputMessage),
                                     message: nil,
                                     dismissButton: .cancel()
                        )
                    case .createSuccess:
                        return Alert(title: Text("Create request success"),
                                     message: nil,
                                     dismissButton: Alert.Button.default(Text("OK"), action: {
                                        resetToDefaultValue()
                                     }))
                }
            })
        }
    }
    
    private func resetToDefaultValue() {
        requestType = "Chọn loại đơn..."
        partialDay = "Cả ngày"
        reason = "Chọn lí do..."
        reasonDetail = ""
        startDate = Date()
        endDate = Date()
    }
}

struct CreateRequestView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRequestView()
    }
}
