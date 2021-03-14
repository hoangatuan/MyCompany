//
//  AllRequestsView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/11/20.
//

import SwiftUI

struct AllRequestsView: View {
    @ObservedObject private var viewModel: AllRequestsViewModel
    
    init() {
        viewModel = AllRequestsViewModel()
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavigationBar(isShowBackButton: true, backButtonTitle: "My Request", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
            ZStack {
                ScrollView {
                    Image("requestHeader")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width / 2)
                    
                    let oneColumnGrid = [GridItem(.flexible())]
                    LazyVGrid(columns: oneColumnGrid, spacing: 16) {
                        ForEach(viewModel.listAllRequests) { request in
                            RequestDetailCell(request: request)
                        }
                    }.padding()
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
                if viewModel.onShowProgress {
                    CustomProgressView()
                }
            }
        }.onAppear(perform: {
            if UserDataDefaults.shared.isAdministrator {
                viewModel.getAllEmployeesRequests()
            } else {
                viewModel.getAllRequests()
            }
        })
    }
}

struct AllRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRequestsView()
    }
}
