//
//  SearchEmployeeView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/29/20.
//

import SwiftUI

struct SearchEmployeeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var inputText: String = ""
    @State private var onShowUpdateInfoView: Bool = false
    @State private var onUpdateSuccess: Bool = false
    @ObservedObject private var viewModel: SearchEmployeeViewModel = SearchEmployeeViewModel()
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 16, height: 20)
                }).frame(width: 32, height: 32)
                .foregroundColor(.black)
                
                SearchBar(inputText: $inputText, placeHolder: "Type employee account to search...", isWhiteBackground: false)
            }
            
            Divider()
                .background(Color.white.shadow(color: Color.gray, radius: 2, x: 0, y: 1))
            
            ScrollView() {
                ForEach(viewModel.employeeDatasToPresent) { info in
                    EmployeeCell(employeeInfo: info, onShowUpdateView: $onShowUpdateInfoView, selectedEmployee: viewModel.selectedEmployeeInfo)
                        .listRowInsets(EdgeInsets())
                }
                
                if viewModel.onShowProgress {
                    CustomProgressView().padding(.top)
                }
                
                if (viewModel.httpStatusCodeFetched != 444) {
                    // No more to loads
                    HStack {
                        Spacer()
                        NewLoadMoreView(action: {
                            viewModel.getAllEmployeeInfoPerPage()
                        })
                        .frame(minWidth: 0, maxWidth: .infinity)
                        Spacer()
                    }
                }
            }
        }.onChange(of: inputText, perform: { value in
            viewModel.searchEmployeeByAccount(account: inputText)
        }).onAppear(perform: {
            if viewModel.allEmployessInfoFetched.isEmpty {
                viewModel.getAllEmployeeInfoPerPage()
            } else {
                viewModel.searchEmployeeByAccount(account: "")
            }
        })
        .sheet(isPresented: $onShowUpdateInfoView, onDismiss: {
            if onUpdateSuccess {
                viewModel.searchEmployeeByAccount(account: inputText)
            }
        }, content: {
            EmployeeInformationView(employeeInfo: viewModel.selectedEmployeeInfo, onUpdateInfoSuccess: $onUpdateSuccess)
        })
        .alert(isPresented: $viewModel.onFetchedFailed, content: {
            Alert(title: Text("Fetch Employee Failed"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }).navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct SearchEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEmployeeView()
    }
}
