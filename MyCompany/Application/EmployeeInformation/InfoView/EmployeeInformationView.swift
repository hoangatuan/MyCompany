//
//  EmployeeInformationView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/11/20.
//

import SwiftUI

struct EmployeeInformationView: View {
    @Binding var onUpdateInfoSuccess: Bool
    @ObservedObject private var viewModel: EmployeeInformationViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(employeeInfo: Employee?, onUpdateInfoSuccess: Binding<Bool>) {
        viewModel = EmployeeInformationViewModel(employeeInfo: employeeInfo)
        _onUpdateInfoSuccess = onUpdateInfoSuccess
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Employee Info", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                ScrollView {
                    AvatarHeaderView(employeeFullname: viewModel.employeeFullname, avatarImageUrl: viewModel.avatarURL, onShowProgress: $viewModel.onShowProgress)
                        .padding().background(Image("background").resizable())
                    
                    if !UserDataDefaults.shared.isAdministrator {
                        SectionHeader(sectionTitle: "General Information",
                                      dataDisplay: $viewModel.infoPresentData)
                    }
                    
                    SectionHeader(sectionTitle: "Contact Information",
                                  dataDisplay: $viewModel.contactInfomationData)
                    SectionHeader(sectionTitle: "Contract Information",
                                  dataDisplay: $viewModel.contractInfomationData)
                    
                    if UserDataDefaults.shared.isAdministrator {
                        Button(action: {
                            viewModel.updateEmployeeInfo()
                        }, label: {
                            Text("Update")
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                        }).frame(width: UIScreen.main.bounds.width - 32)
                        .background(Color.blue)
                        .cornerRadius(30.0)
                        .padding()
                    }
                    
                }.onAppear(perform: {
                    viewModel.requestEmployeeInformation()
                    onUpdateInfoSuccess = false
                }).navigationBarTitle("")
                .navigationBarHidden(true)
            }
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }
        .alert(isPresented: $viewModel.onShowAlert, content: {
            switch viewModel.updateState {
            case .success:
                return Alert(title: Text("Update success!"), message: nil, dismissButton: .default(Text("OK"), action: {
                    onUpdateInfoSuccess = true
                    presentationMode.wrappedValue.dismiss()
                }))
            case .fail:
                return Alert(title: Text("Update failed!"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        })
    }
}

struct EmployeeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeInformationView(employeeInfo: nil, onUpdateInfoSuccess: .constant(false))
    }
}


struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
