//
//  BusInfoCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/20/20.
//

import SwiftUI

struct BusInfoCell: View {
    var busInfo: BusInfo
    
    var body: some View {
        VStack {
            HStack {
                Text(busInfo.numbOrder)
                    .padding(.trailing)
                    .foregroundColor(.black)
                    
                Text(busInfo.name)
                    .foregroundColor(.black)
                Spacer()
                Text(busInfo.pickTime + "/" + busInfo.dropTime)
                    .foregroundColor(.black)
            }
            
            Divider()
        }.padding([.leading, .trailing, .top])
    }
}

struct BusInfoCell_Previews: PreviewProvider {
    static let businfo = BusInfo(numbOrder: "1.1", name: "Lac Long Quan",
                                 pickTime: "7h35", dropTime: "17h30",
                                 route: [], hotline: "123",
                                 account: "TuanHA24", telephone: "123456")
    static var previews: some View {
        BusInfoCell(busInfo: businfo)
            .previewLayout(.sizeThatFits)
    }
}
