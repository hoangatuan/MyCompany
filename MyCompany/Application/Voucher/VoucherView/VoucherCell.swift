//
//  VoucherCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import SwiftUI

struct VoucherCell: View {
    var voucher: Voucher
    @ObservedObject var viewModel: VoucherCellViewModel
    
    init(voucher: Voucher) {
        self.voucher = voucher
        viewModel = VoucherCellViewModel()
        viewModel.loadNewsImage(urlString: voucher.imageURL, voucherID: voucher.voucherID)
    }
    
    var body: some View {
        NavigationLink(destination: VoucherContentView(voucherContent: viewModel.contentFetched, voucher: voucher), isActive: $viewModel.onFetchContentSuccess, label: {
            VStack {
                let width = (UIScreen.main.bounds.width - 32) / 2
                
                Image(uiImage: viewModel.voucherImage)
                    .resizable()
                    .frame(width: width, height: width * 2 / 3)
                
                HStack {
                    Text(voucher.title)
                        .bold()
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                        .frame(height: 40)
                        .padding(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 0.0))
                    Spacer()
                }
                
                HStack {
                    HStack(spacing: 0.0) {
                        Image(systemName: "arrow.down")
                            .resizable().frame(width: 8, height: 8, alignment: .center)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 2.0))
                        Text(voucher.discountDescription)
                            .font(Font.system(size: 10))
                            .foregroundColor(.black)
                    }.padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    .background(Color(UIColor.ColorE9E9E9))
                    .cornerRadius(3.0)
                    
                    Spacer()
                }.padding(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 0.0))
                
                VStack(alignment: .center, spacing: 0.0, content: {
                    HStack {
                        Text("\(voucher.afterCost) VNĐ")
                            .bold()
                            .foregroundColor(Color.orange)
                            .font(Font.system(size: 16))
                        Spacer()
                    }
                    
                    HStack {
                        CrossOffTextView(text: "\(voucher.beforeCost) VNĐ")
                        Spacer()
                    }
                }).padding(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 0.0))
                    
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .onTapGesture(perform: {
                viewModel.fetchVoucherContent(of: voucher.voucherID)
            }).alert(isPresented: $viewModel.onFetchContentFailed, content: {
                Alert(title: Text(viewModel.errorMessage), message: nil, dismissButton: .none)
            })
        })
    }
}

struct VoucherCell_Previews: PreviewProvider {
    static var previews: some View {
        VoucherCell(voucher: Voucher(title: "FPT ", imageURL: "dsdsd", discountDescription: "", beforeCost: 200, afterCost: 100))
            .previewLayout(.fixed(width: 183, height: 275))
    }
}
