//
//  SearchRequestView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/27/20.
//

import SwiftUI

struct SearchRequestView: View {
    @State private var searchText: String = ""
    @State private var selectedIndex: Int = 0
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    let valuesArray: [String] = ["All", "Pending", "Approved", "Denied"]
    @State private var onShowApproveView: Bool = false
    @State private var selectedRequest: Request = Request(requestType: "", account: "", fullName: "",
                                                          imageURL: "", startDate: "", endDate: "", partialDay: "",
                                                          reason: "", reasonDetail: "", status: 0, approveDate: "", approveNote: "")
    @ObservedObject var viewModel: SearchRequestViewModel = SearchRequestViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                SearchHeaderView(newType: $selectedIndex, searchTitle: $searchText,
                                 placeHolder: "Type account to search...", valuesArray: valuesArray)
                
                ScrollView() {
                    ForEach(viewModel.filterRequestsByStatus(status: selectedIndex)) { request in
                        SearchRequestCell(request: request, selectedRequest: $selectedRequest)
                            .listRowInsets(EdgeInsets())
                        
                    }
                }
            }.onChange(of: searchText, perform: { value in
                viewModel.inputText = searchText
            }).onChange(of: selectedIndex, perform: { value in
                viewModel.inputText = searchText
            })
            
            if viewModel.filterRequestsByStatus(status: selectedIndex).isEmpty {
                ZStack {
                    let title = viewModel.didSearchFirstTime ? "Nothing matching your keyword is found" : "Please type your keyword to search"
                    Text(title)
                }
            }
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }
        .onAppear(perform: {
            viewModel.inputText = ""
        })
        .onChange(of: selectedRequest, perform: { value in
            onShowApproveView = true
        }).sheet(isPresented: $onShowApproveView, onDismiss: {
            if viewModel.isNeedReload {
                viewModel.inputText = searchText
            }
        }, content: {
            ApproveRequestView(request: selectedRequest, isEditable: selectedRequest.status == 0)
        })

        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct SearchRequestView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRequestView()
    }
}
