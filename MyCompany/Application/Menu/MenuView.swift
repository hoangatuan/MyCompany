//
//  MenuView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/15/20.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var moveToRoot: Bool = false
}

struct MenuView: View {
    @Binding var onShowScanQRCode: Bool
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: EmployeeInformationView(employeeInfo: nil, onUpdateInfoSuccess: .constant(false)),
                label: {
                    VStack {
                        Image("icon_menu_employeeInfo")
                            .resizable().frame(width: 20, height: 20)
                            .padding(.all, 12)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .foregroundColor(.black)
                        
                        Text("Information")
                            .foregroundColor(.black)
                    }
                }).frame(minWidth: 0, maxWidth: .infinity)
            
            NavigationLink(
                destination: SupportView(),
                label: {
                    VStack {
                        Image("icon_bus_secretary")
                            .resizable().frame(width: 20, height: 20)
                            .padding(.all, 12)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .foregroundColor(.black)
                        
                        Text("Support")
                            .foregroundColor(.black)
                    }
                }).frame(minWidth: 0, maxWidth: .infinity)
            
            Button(action: {
                onShowScanQRCode = true
            }, label: {
                VStack {
                    Image("icon_menu_scanQR")
                        .resizable().frame(width: 20, height: 20)
                        .padding(.all, 12)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .foregroundColor(.black)
                    
                    Text("Scan QR")
                        .foregroundColor(.black)
                }
            }).frame(minWidth: 0, maxWidth: .infinity)
            
            NavigationLink(
                destination: ExchangeCoinView(),
                label: {
                    VStack {
                        Image("icon_menu_buycoin")
                            .resizable().frame(width: 20, height: 20)
                            .padding(.all, 12)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .foregroundColor(.black)
                        
                        Text("Buy Coin")
                            .foregroundColor(.black)
                    }
                }).frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(onShowScanQRCode: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
