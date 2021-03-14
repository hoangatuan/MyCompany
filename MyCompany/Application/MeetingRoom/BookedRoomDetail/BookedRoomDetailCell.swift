//
//  BookedRoomDetailCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/7/20.
//

import SwiftUI

struct BookedRoomDetailCell: View {
    let leftText: String
    let rightText: String
    
    var body: some View {
        VStack {
            Divider()
                .frame(height: 1)
            HStack {
                Text(leftText)
                Spacer()
                Text(rightText)
            }
        }.padding([.leading, .trailing, .top])
    }
}

struct BookedRoomDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        BookedRoomDetailCell(leftText: "Creator", rightText: "TuanHA24")
            .previewLayout(.sizeThatFits)
    }
}
