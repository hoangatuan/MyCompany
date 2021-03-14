//
//  VouchersView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import SwiftUI

struct VouchersView: View {
    @ObservedObject var viewModel: VouchersViewModel = VouchersViewModel()
    @State private var showHistoryView: Bool = false
    
    var body: some View {
        let width = (UIScreen.main.bounds.width - 32) / 2
        let colums = [
            GridItem(.flexible(minimum: width, maximum: width), spacing: 16),
            GridItem(.flexible(minimum: width, maximum: width), spacing: 0) // Right, left spacing
        ]
        
        VStack {
            CustomRightActionNavBar(navBarTitle: "Vouchers", isShowBackButton: false, rightButtonTitle: "History", actionRightButton: {
                showHistoryView = true
            })
            
            NavigationLink(
                destination: OrderHistoryView(),
                isActive: $showHistoryView,
                label: {

                })
            
            ZStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: colums, alignment: .center, spacing: 16, content: { // Row spacing
                        ForEach(viewModel.listItemsToDisplay, content: { item in
                            VoucherCell(voucher: item)
                        })
                    })
                    
                    if viewModel.httpStatusCode != 444 { // No more to loads
                        HStack {
                            Spacer()
                            NewLoadMoreView(action: {
                                viewModel.fetchVouchers()
                            })
                            .frame(minWidth: 0, maxWidth: .infinity)
                            Spacer()
                        }.padding()
                    }
                    
                }.padding(EdgeInsets(top: 4.0, leading: 0.0, bottom: 0.0, trailing: 0.0)) // For not scroll over status bar
                
                if viewModel.onShowProgress {
                    CustomProgressView()
                }
            }
        }.onAppear(perform: {
            if viewModel.listItemsToDisplay.isEmpty {
                viewModel.fetchVouchers()
            }
        })
        .alert(isPresented: $viewModel.onFetchVouchersFailed, content: {
            Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .cancel())
        })
    }
}

struct VouchersView_Previews: PreviewProvider {
    static var previews: some View {
        VouchersView()
    }
}
