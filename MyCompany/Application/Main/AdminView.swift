//
//  AdminView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/1/20.
//

import SwiftUI

struct AdminView: View {
    @State private var selectedCommand: AdminCommandType = .none
    @State private var onDisplaySearchRequest: Bool = false
    @State private var onDisplayApproveRequest: Bool = false
    @State private var onDisplayUpdateInfo: Bool = false
    @State private var onDisplayExchangeCoin: Bool = false
    
    let itemDisplays: [AdminCommandType] = [.searchRequest, .approveRequest, .updateInfo, .exchangeRequest]
    let imageName: [String] = ["searchRequest", "approveNow", "updateEmployeeInfo", "eshake"]
    let commandDescriptions: [String] = ["Search all approved, pending or denied requests of all employees",
                                         "Approve or deny a request of a specific employee",
                                         "Update contact information and contract information of a specific employee",
                                         "Search and get detail of an exchange coin request of a specific employee"]
    let colors: [UIColor] = [UIColor.Color3B13B8, UIColor.ColorFF596E, UIColor.Color007AFF, UIColor.Color02CEFD]
    
    var body: some View {
        
        let width = (UIScreen.main.bounds.width - 32) / 2
        let colums = [
            GridItem(.flexible(minimum: width, maximum: width), spacing: 16),
            GridItem(.flexible(minimum: width, maximum: width), spacing: 0) // Right, left spacing
        ]
        
        NavigationView {
            VStack {
                CustomNavigationBar(isShowBackButton: false, backButtonTitle: "", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                
                NavigationLink(
                    destination: SearchRequestView(),
                    isActive: $onDisplaySearchRequest,
                    label: {})
                
                NavigationLink(
                    destination: AllRequestsView(),
                    isActive: $onDisplayApproveRequest,
                    label: {})
                
                NavigationLink(
                    destination: SearchEmployeeView(),
                    isActive: $onDisplayUpdateInfo,
                    label: {})
                
                NavigationLink(
                    destination: SearchExchangeCoinView(),
                    isActive: $onDisplayExchangeCoin,
                    label: {})
                
                ScrollView(.vertical) {
                    Text("W O R K I N G")
                        .foregroundColor(Color(UIColor.ColorFF88A7))
                        .bold()
                        .font(Font.system(size: 32))
                        .padding()
                    
                    LazyVGrid(columns: colums, alignment: .center, spacing: 32, content: { // Row spacing
                        ForEach((0..<itemDisplays.count), id: \.self) { index in
                            AdminCommandCell(imageName: imageName[index], command: itemDisplays[index],
                                             description: commandDescriptions[index], color: colors[index], selectedCommand: $selectedCommand)
                        }
                    })
                }
            }.navigationBarTitle("", displayMode: .large)
            .navigationBarHidden(true)
            .onChange(of: selectedCommand, perform: { value in
                switch value {
                case .searchRequest:
                    onDisplaySearchRequest = true
                case .approveRequest:
                    onDisplayApproveRequest = true
                case .updateInfo:
                    onDisplayUpdateInfo = true
                case .exchangeRequest:
                    onDisplayExchangeCoin = true
                case .none:
                    return
                }
                
                selectedCommand = .none
            }).padding(.top, 4)
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
