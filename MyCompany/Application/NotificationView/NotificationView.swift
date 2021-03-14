//
//  NotificationView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/2/20.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject private var viewModel: NotificationViewModel = NotificationViewModel()
    
    var body: some View {
        VStack {
            CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Notification", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
            
            ZStack {
                ScrollView {
                    ForEach(viewModel.listApprovedRequests) { request in
                        NavigationLink(
                            destination: ApproveRequestView(request: request, isEditable: false),
                            label: {
                                NotificationCell(request: request)
                                    .listRowInsets(EdgeInsets())
                            })
                    }
                }

                if viewModel.onShowProgress {
                    CustomProgressView()
                        .padding(.top, 8)
                }
            }
        }.onAppear(perform: {
            viewModel.listApprovedRequests = []
            viewModel.getAllApprovedRequest()
        }).alert(isPresented: $viewModel.onShowAlert, content: {
            Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .default(Text("OK")))
        }).navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
