//
//  VoucherContentHeaderView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import SwiftUI

struct VoucherContentHeaderView: View {
    var voucher: Voucher
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack {
                Text(voucher.title)
                    .font(Font.system(size: 16))
                    .bold()
                    .fixedSize(horizontal: false, vertical: true) // Fix bug text not wrapped: https://stackoverflow.com/questions/56505929/the-text-doesnt-get-wrapped-in-swift-ui
                Spacer()
            }.padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
            
            HStack {
                Text("Giảm giá \(voucher.discountDescription)")
                    .foregroundColor(.green)
                    .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
                    .background(Color(UIColor.ColorE9E9E9))
                    .cornerRadius(3.0)
                Spacer()
            }.padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
            
            VStack(spacing: 4.0) {
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
            }.padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
            
            Divider().frame(width: UIScreen.main.bounds.width, height: 8.0, alignment: .center)
                .background(Color(UIColor.ColorE9E9E9))
        }
    }
}

struct VoucherContentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherContentHeaderView(voucher: Voucher(title: "", imageURL: "", discountDescription: "", beforeCost: 100, afterCost: 200))
                .previewLayout(.sizeThatFits)
    }
}
