//
//  OrderHistorycell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import SwiftUI

struct OrderHistoryCell: View {
    var order: BoughtVoucher
    @ObservedObject private var viewModel = OrderHistoryCellViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Image(uiImage: viewModel.voucherImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading, spacing: 4) {
                    Text(order.voucherTitle)
                    Text("Ngày đặt: \(order.buyDate)")
                        .font(Font.system(size: 14))
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Chi phí thanh toán:")
                    Text("\(order.cost) VND")
                        .foregroundColor(.red)
                }
                
                HStack {
                    Text("Trạng thái:")
                    Text(order.status == 0 ? "Đang vận chuyển" : "Đã nhận hàng")
                        .foregroundColor(order.status == 0 ? .accentColor : .green)
                }
            }
            
            VStack(alignment: .leading) {
                LeadingText(text: "Địa chỉ và thông tin người nhận hàng")
                
                HStack {
                    Image("icon_voucher_email")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Email: ")
                    Text(order.email)
                }
                
                HStack {
                    Image("icon_voucher_phone")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Điện thoại: ")
                    Text(order.phone)
                }
                
                HStack {
                    Image("icon_voucher_address")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Địa chỉ nhận hàng: ")
                    Text(order.address)
                }
            }
        }.padding()
        .onAppear(perform: {
            viewModel.loadVoucherImage(urlString: order.imageURL, voucherID: order.voucherID)
        })
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: .gray, radius: 4, x: 0, y: 2))
    }
}

struct OrderHistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryCell(order: BoughtVoucher(email: "abc@gmail.com",
                                              phone: "123456",
                                              address: "Ha Noi",
                                              note: "",
                                              cost: 100000,
                                              voucherTitle: "Hoang Ha Mobile - Airpod2 giam gia 3 trieu",
                                              buyDate: "22-Nov-2020", imageURL: "", status: 0))
    }
}
