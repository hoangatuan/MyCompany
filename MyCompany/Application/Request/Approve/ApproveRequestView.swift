//
//  ApproveRequestView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/26/20.
//

import SwiftUI

struct ApproveRequestView: View {
    @State private var approveNote: String = ""
    @ObservedObject private var viewModel: ApproveRequestViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var isEditable: Bool
    
    init(request: Request, isEditable: Bool) {
        viewModel = ApproveRequestViewModel(request: request)
        self.isEditable = isEditable
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomRightActionNavBar(navBarTitle: "Approval", isShowBackButton: true, rightButtonTitle: "", actionRightButton: {})
            ScrollView {
                VStack(spacing: 12.0) {
                    // Avatar image
                    Image(uiImage: viewModel.avatarImage)
                        .clipShape(Circle())
                    Text("Hoang Anh Tuan")
                        .font(Font.headline)
                    
                    Group {
                        InputInformationCell(inputText: .constant(viewModel.request.account),
                                             title: "Account", placeholder: "", imageName: "", isDisableEditing: true)
                        InputInformationCell(inputText: .constant(viewModel.request.requestType),
                                             title: "Request Type", placeholder: "", imageName: "", isDisableEditing: true)
                        HStack {
                            InputInformationCell(inputText: .constant(viewModel.request.startDate),
                                                 title: "Start Date", placeholder: "", imageName: "", isDisableEditing: true)
                            InputInformationCell(inputText: .constant(viewModel.request.endDate),
                                                 title: "End Date", placeholder: "", imageName: "", isDisableEditing: true)
                        }
                        
                        InputInformationCell(inputText: .constant(viewModel.request.partialDay),
                                             title: "Partial Day", placeholder: "", imageName: "", isDisableEditing: true)
                        InputInformationCell(inputText: .constant(viewModel.request.reason),
                                             title: "Reason", placeholder: "", imageName: "", isDisableEditing: true)
                        InputInformationCell(inputText: .constant(viewModel.request.reasonDetail),
                                             title: "Reason Detail", placeholder: "", imageName: "", isDisableEditing: true)
                        if !isEditable {
                            let status = StatusRequest(rawValue: viewModel.request.status) ?? .pending
                            InputInformationCell(inputText: .constant(status.toString()),
                                                 title: "Approval Status", placeholder: "", imageName: "", isDisableEditing: true)
                        }
                        
                        let placeholder = isEditable ? "Input note here if you deny this request..." : ""
                        InputInformationCell(inputText: $approveNote,
                                             title: "Approve Note", placeholder: placeholder, imageName: "", isDisableEditing: !isEditable)
                        
                        if !isEditable {
                            InputInformationCell(inputText: .constant(viewModel.request.approveDate),
                                                 title: "Approve Date", placeholder: "", imageName: "", isDisableEditing: true)
                        }
                    }
                    
                    if isEditable {
                        HStack {
                            Button(action: {
                                viewModel.approve(approveStatus: .approve, approveNote: approveNote)
                            }, label: {
                                Text("APPROVE")
                                    .foregroundColor(.white)
                            }).padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10.0)
                            
                            Button(action: {
                                viewModel.approve(approveStatus: .deny, approveNote: approveNote)
                            }, label: {
                                Text("REJECT")
                                    .foregroundColor(.white)
                            }).padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10.0)
                        }
                    }
                }.padding()
            }.onAppear(perform: {
                viewModel.loadAvasImage()
                approveNote = viewModel.request.approveNote
            }).alert(isPresented: $viewModel.onShowAlert, content: {
                if viewModel.status == .emptyInput {
                    return Alert(title: Text(viewModel.status.rawValue), message: nil, dismissButton: .default(Text("OK")))
                } else {
                    return Alert(title: Text(viewModel.status.rawValue), message: nil,
                                 dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                }
            }).navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct ApproveRequestView_Previews: PreviewProvider {
    static var previews: some View {
        ApproveRequestView(request: Request(requestType: "Nghi khong luong", account: "TuanHA24",
                                            fullName: "Hoang Anh Tuan", imageURL: "",
                                            startDate: "10-Nov-2020", endDate: "11-Nov-2020",
                                            partialDay: "Buoi sang", reason: "Ly do suc khoe ca nhan", reasonDetail: "", status: 0, approveDate: "", approveNote: ""), isEditable: false)
    }
}
