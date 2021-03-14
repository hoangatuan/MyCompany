//
//  BusSecretaryView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/15/20.
//

import SwiftUI

struct BusSecretaryView: View {
    var account: String
    var telephone: String
    
    var body: some View {
        HStack {
            Spacer().frame(width: 24)
            Text(account)
                .bold()
            Spacer()
            Image("icon_bus_phone")
                .resizable()
                .frame(width: 28, height: 28, alignment: .center)
            
            Button(action: {
                CoreService.callNumber(phoneNumber: telephone)
            }, label: {
                Text(telephone)
            })
        }.padding()
    }
}

struct BusSecretaryView_Previews: PreviewProvider {
    static var previews: some View {
        BusSecretaryView(account: "NgocNB1", telephone: "0912038567")
            .previewLayout(.sizeThatFits)
    }
}
