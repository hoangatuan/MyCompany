//
//  ExchangeCoinCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 1/1/21.
//

import SwiftUI

struct ExchangeCoinCell: View {
    var exchangeCoinRequest: CoinRequest
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("icon_coin_employee")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Account:")
                    .bold()
                
                Text(exchangeCoinRequest.account)
                
                Spacer()
            }
            
            HStack {
                Image("icon_coin_calendar")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Exchange date:")
                    .bold()
                
                let date = Date(timeIntervalSince1970: exchangeCoinRequest.date)
                let dateString = date.convertToFormat(format: .comment)
                
                Text(dateString)
            }
            
            HStack {
                Image("icon_menu_coin")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Total coins:")
                    .bold()
                
                Text(exchangeCoinRequest.coinsPay ?? "0")
            }
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: .gray, radius: 4, x: 0, y: 0)
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
    }
}

struct ExchangeCoinCell_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeCoinCell(exchangeCoinRequest: CoinRequest(coinsPay: "100", date: 1609504623.0, type: CoinType.exchange.rawValue, storeName: "", totalCoin: 0))
            .previewLayout(.sizeThatFits)
    }
}
