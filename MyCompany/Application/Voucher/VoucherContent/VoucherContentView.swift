//
//  VoucherContentView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import SwiftUI

struct VoucherContentView: View {
    var voucherContent: VoucherContent
    var voucher: Voucher
    @State private var onShowOrderVoucherView: Bool = false
    @ObservedObject var viewModel: VoucherContentViewModel
    
    init(voucherContent: VoucherContent, voucher: Voucher) {
        self.voucherContent = voucherContent
        self.voucher = voucher
        viewModel = VoucherContentViewModel(imageURLs: voucherContent.imageDescriptionURL)
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavigationBar(isShowBackButton: true, backButtonTitle: "", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
            
            NavigationLink(
                destination: OrderVoucherView(cost: voucher.afterCost, voucher: voucher),
                isActive: $onShowOrderVoucherView,
                label: {
                    
                })
            
            ScrollView(.vertical) {
                ScrollView(.horizontal) {
                    let row = [GridItem(.flexible())]
                    LazyHGrid(rows: row, alignment: .center, spacing: 0.0, content: {
                        ForEach((0..<viewModel.imagesDescription.count), id: \.self) { index in
                            let image = viewModel.imagesDescription[index]
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width)
                        }
                    })
                    .frame(height: UIScreen.main.bounds.width * 2 / 3)
                }
                
                VoucherContentHeaderView(voucher: voucher)
                
                HStack {
                    Text("Voucher's description")
                        .bold()
                        .font(Font.system(size: 18))
                    Spacer()
                }.padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
                
                ForEach(voucherContent.contents) { content in
                    ContentCell(content: content, cacheType: .voucherDescriptionImage)
                }
                
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
            Button(action: {
                onShowOrderVoucherView = true
            }, label: {
                Text("BUY NOW")
                    .foregroundColor(.white)
            }).padding()
            .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
            .background(Color(UIColor.ColorFF88A7))
            .cornerRadius(10.0)
            .padding()
        }
        .onAppear(perform: {
            viewModel.loadAllDescriptionImages()
        })
    }
}

struct VoucherContentView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherContentView(voucherContent: VoucherContent(imageDescriptionURL: [], voucherID: "", contents: []),
                           voucher: Voucher(title: "", imageURL: "", discountDescription: "", beforeCost: 100, afterCost: 200))
    }
}
