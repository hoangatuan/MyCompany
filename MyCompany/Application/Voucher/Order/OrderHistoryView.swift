//
//  OrderHistoryView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import SwiftUI

struct OrderHistoryView: View {
    @ObservedObject private var viewModel = OrderHistoryViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                let oneColumnGrid = [GridItem(.flexible())]
                LazyVGrid(columns: oneColumnGrid, spacing: 16) {
                    if let vouchers = viewModel.listBoughtVouchers {
                        ForEach(vouchers) { boughtVoucher in
                            OrderHistoryCell(order: boughtVoucher)
                        }
                    }
                }.padding()
            }.padding(.top, 4)
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }
        .alert(isPresented: $viewModel.onFetchVouchersFailed, content: {
            Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .default(Text("OK")))
        })
        .onAppear(perform: {
            viewModel.listBoughtVouchers = []
            viewModel.loadAllBoughtVouchers()
        }).navigationTitle("History")
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
