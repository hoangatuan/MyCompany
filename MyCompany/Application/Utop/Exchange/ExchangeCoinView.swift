//
//  ExchangeCoinView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/8/20.
//

import SwiftUI

struct ExchangeCoinView: View {
    @State private var inputExchangeMoney: String = "0"
    @State private var exchangeCoin: String = "0"
    @ObservedObject private var viewModel = ExchangeCoinViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Exchange Coin", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Exchange Guide")
                                .font(Font.system(size: 24))
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("1 Coin corresponds to 1000 VND")
                                .foregroundColor(.gray)
                            
                            Text("Up to 1,000,000 VND for 1 exchange")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }.padding(.vertical)
                    
                    Spacer()
                    
                    HStack {
                        Text("Enter redemption points")
                            .font(Font.system(size: 24))
                            .bold()
                        Spacer()
                    }.padding(.vertical)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Redemption moneys")
                            Spacer()
                        }
                        
                        ZStack {
                            HStack {
                                Spacer()
                                Text("VND")
                            }
                            
                            CoinCustomTextfieldView(inputText: $inputExchangeMoney, textAlignment: .center, coinType: .exchange, onTextDidChange: { value in
                                exchangeCoin = "\(Int(value / 1000))"
                            }).frame(height: 60, alignment: .center)
                            
                        }.padding(.bottom)
                        
                        Divider().frame(height: 2, alignment: .center)
                            .background(Color(UIColor.ColorFF88A7))
                        
                        HStack {
                            Text("Coin receive")
                            Spacer()
                        }.padding(.top)
                        
                        ZStack {
                            HStack {
                                Spacer()
                                Text("Coins")
                            }
                            
                            Text(exchangeCoin)
                                .font(Font.system(size: 28))
                        }
                    }.padding()
                    
                    .background(Color(UIColor.ColorE9E9E9))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 4, x: 0, y: 0)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.startExchangeCoin(coins: exchangeCoin)
                    }, label: {
                        Text("Exchange")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                    }).frame(width: UIScreen.main.bounds.width - 32)
                    .background(Color(UIColor.ColorFF88A7))
                    .cornerRadius(30.0)
                    .padding(.vertical)
                }
                .padding()
            }
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }.alert(isPresented: $viewModel.onShowAlert, content: {
            switch viewModel.state {
                case .success:
                    return Alert(title: Text("Exchange Success"), message: nil, dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                case .fail:
                    return Alert(title: Text("Exchange Failed"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }).navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ExchangeCoinView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeCoinView()
    }
}
