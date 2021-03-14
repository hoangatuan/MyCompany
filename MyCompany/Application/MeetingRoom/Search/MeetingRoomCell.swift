//
//  MeetingRoomCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/3/20.
//

import SwiftUI

struct MeetingRoomCell: View {
    var roomInfo: MeetingRoom
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(roomInfo.name)
                        .font(Font.custom("OpticSans-201Book", size: 18))
                        .foregroundColor(.black)
                        .bold()
                    Text(roomInfo.building)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }.padding([.leading, .trailing, .top])
            
            Divider().frame(width: UIScreen.main.bounds.width,
                            height: 1)
        }
    }
}

struct MeetingRoomCell_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomCell(roomInfo: MeetingRoom(name: "Dong Ho", polycom: "", location: "FPT Cau giay", building: "FHN", maxSeats: 10))
    }
}
