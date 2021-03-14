//
//  MeetingRoomDetailCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/3/20.
//

import SwiftUI

struct MeetingRoomDetailCell: View {
    var title: String
    var imageName: String
    var content: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
            }
            
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                Text(content)
                Spacer()
            }
            
            Divider()
                .frame(height: 1, alignment: .center)
        }.padding([.leading, .trailing, .top])
    }
}

struct MeetingRoomDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomDetailCell(title: "Polycom", imageName: "network", content: "42.112.193.3")
            .previewLayout(.sizeThatFits)
    }
}
