//
//  PaymentStatusView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/7/20.
//

import SwiftUI

struct PaymentStatusView: View {
    var coinRequest: CoinRequest
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            CustomRightActionNavBar(navBarTitle: "Payment Status", isShowBackButton: false, rightButtonTitle: "", actionRightButton: {})
            
            Text("Pay successfully")
                .font(Font.system(size: 24))
                .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
            
            Spacer()
            
            Text("\(coinRequest.coinsPay ?? "0") Coins")
                .font(Font.system(size: 32))
                .bold().padding()
            
            VStack(spacing: 0.0) {
                HStack {
                    Text("Payment Detail")
                        .bold()
                        .padding(.bottom, 32)
                }
                
                HStack {
                    Text("Coin used")
                    Spacer()
                    Text("\(coinRequest.coinsPay ?? "0") Coins")
                        .foregroundColor(Color(UIColor.ColorFF88A7))
                }.padding(.bottom, 8)
                
                HStack {
                    Text("Store")
                    Spacer()
                    Text(coinRequest.storeName)
                }.padding(.bottom, 8)
                
                HStack {
                    Text("Payment time")
                    Spacer()
                    VStack(alignment: .trailing) {
                        let date = Date(timeIntervalSince1970: coinRequest.date)
                        
                        Text(date.convertToFormat(format: .iso))
                        Text(date.convertToFormat(format: .HMS))
                    }
                }.padding(.bottom, 32)
            }.padding()
            .background(Color.white, alignment: .center)
            .cornerRadius(10.0)
            .shadow(color: .gray, radius: 4, x: 0.0, y: 0.0)
            .padding()
            
            Spacer()
            
            Button(action: {
                appState.moveToRoot = true
            }, label: {
                Text("Back to Home")
                    .foregroundColor(Color(UIColor.ColorFF88A7))
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 20.0)
                                .stroke(Color(UIColor.ColorFF88A7), lineWidth: 2.0))
            }).padding()
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct PaymentStatusView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentStatusView(coinRequest: CoinRequest(coinsPay: "10", date: 1607356966.47675,
                                                   type: 1, storeName: "Starbucks", totalCoin: 300))
    }
}
