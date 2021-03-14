//
//  InputPayment.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/7/20.
//

import SwiftUI

struct InputPaymentView: View {
    @State private var inputMoney: String = ""
    @ObservedObject private var viewModel = InputPaymentViewModel()
    @EnvironmentObject var appState: AppState
    
    var store: Store
    
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                NavigationLink(
                    destination: PaymentStatusView(coinRequest: viewModel.coinRequest).environmentObject(appState),
                    isActive: $viewModel.onPaySuccess,
                    label: {
                    }).isDetailLink(false)
                
                CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Payment", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                LeadingText(text: "Store").padding()
                HStack(spacing: 0.0) {
                    Image("luxstay")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    Text(store.name)
                        .font(Font.system(size: 24))
                        .bold()
                    
                    Spacer()
                }.background(Color(UIColor.ColorE9E9E9))

                HStack {
                    Text("Payment amount")
                        .font(Font.system(size: 24))
                        .bold()
                        .padding()
                    
                    Spacer()
                }
                
                CoinCustomTextfieldView(inputText: $inputMoney, textAlignment: .left, coinType: .payment, onTextDidChange: { value in
                    inputMoney = String(value)
                })
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .frame(width: UIScreen.main.bounds.width - 32, height: 60, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color.gray, lineWidth: 2.0))
                
                HStack {
                    Text("Equivalent to \(convertInputCoinToVND(coin: inputMoney)) VND")
                        .padding()
                    Spacer()
                }
                
                HStack(spacing: 16.0) {
                    Button(action: {
                        inputMoney = "30"
                    }, label: {
                        Text("30 Coin")
                            .foregroundColor(Color(UIColor.ColorFF88A7))
                            .padding()
                    }).frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.gray, lineWidth: 1))
                    
                    Button(action: {
                        inputMoney = "60"
                    }, label: {
                        Text("60 Coin")
                            .foregroundColor(Color(UIColor.ColorFF88A7))
                            .padding()
                    }).frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.gray, lineWidth: 1))
                    
                    Button(action: {
                        inputMoney = "100"
                    }, label: {
                        Text("100 Coin")
                            .foregroundColor(Color(UIColor.ColorFF88A7))
                            .padding()
                    }).frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.gray, lineWidth: 1))
                }.padding(.all, 16)
                
                Group {
                    Spacer()
                    
                    Button(action: {
                        viewModel.state = .confirmPayment
                        viewModel.onShowAlert = true
                    }, label: {
                        Text("Pay")
                            .foregroundColor(.white)
                    })
                    .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .background(Color(UIColor.ColorFF88A7))
                    .cornerRadius(30.0)
                    .padding(.top, 48)
                    
                    Spacer()
                }
            }
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }.alert(isPresented: $viewModel.onShowAlert, content: {
            switch viewModel.state {
                case .confirmPayment:
                    return Alert(title: Text("Confirm Payment?"), message: nil, primaryButton: .default(Text("Yes"), action: {
                        viewModel.sendRequestPay(storeID: store.storeID, coins: inputMoney)
                    }), secondaryButton: .default(Text("Cancel")))
                case .invalidPayment:
                    return Alert(title: Text("Invalid Payment"), message: Text(viewModel.errorMessage),
                                 dismissButton: .default(Text("OK")))
                case .fail:
                    return Alert(title: Text(viewModel.errorMessage), message: nil,
                                 dismissButton: .default(Text("OK")))
            }
        })
        
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private func convertInputCoinToVND(coin: String) -> String {
        let coinsIntValue = Int(coin) ?? 0
        let moneyVND = String(coinsIntValue * 1000)
        return Converter.formatNumberToReadableMoney(num: moneyVND)
    }
}

struct InputPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        InputPaymentView(store: Store(name: "Starbucks"))
    }
}
