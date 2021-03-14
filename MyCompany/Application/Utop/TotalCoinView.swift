//
//  TotalCoinView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/9/20.
//

import SwiftUI

struct TotalCoinView: View, Equatable {
    static func == (lhs: TotalCoinView, rhs: TotalCoinView) -> Bool {
        return lhs.viewModel.totalCoin == rhs.viewModel.totalCoin
    }
    
    @ObservedObject private var viewModel: TotalCoinViewModel
    
    init(coinViewModel: TotalCoinViewModel) {
        viewModel = coinViewModel
    }
    
    var body: some View {
        HStack(spacing: 0.0) {
            Text("Your total Coins")
            Spacer()
            Text("\(viewModel.totalCoin)")
                .font(Font.system(size: 24))
                .bold()
                .foregroundColor(Color(UIColor.ColorFF88A7))
            Image("icon_menu_coin")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 2, x: 0, y: 0)
    }
}

struct TotalCoinView_Previews: PreviewProvider {
    static var previews: some View {
        TotalCoinView(coinViewModel: TotalCoinViewModel(totalCoin: 0))
            .previewLayout(.sizeThatFits)
    }
}
