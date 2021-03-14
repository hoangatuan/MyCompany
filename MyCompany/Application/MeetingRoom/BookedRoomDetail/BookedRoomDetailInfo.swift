//
//  BookedRoomDetailInfo.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/7/20.
//

import SwiftUI

struct BookedRoomDetailInfo: View {
    var bookedInfo: BookedRoom
    @Binding var isShow: Bool
    
    var body: some View {
        VStack {
            Text("BOOKED ROOM")
                .bold()
            BookedRoomDetailCell(leftText: "Creator", rightText: bookedInfo.account)
            BookedRoomDetailCell(leftText: "Room name", rightText: getRoomName(by: bookedInfo.roomID))
            BookedRoomDetailCell(leftText: "Date", rightText: bookedInfo.date)
            
            let startTime = Converter.convertTimeFromDoubleToString(timeValue: bookedInfo.startTime)
            let endTime = Converter.convertTimeFromDoubleToString(timeValue: bookedInfo.endTime)
            BookedRoomDetailCell(leftText: "Time",
                                 rightText: "\(startTime) - \(endTime)")
            BookedRoomDetailCell(leftText: "Title", rightText: "")
            LeadingText(text: bookedInfo.title)
                .padding()
            
            Spacer().frame(height: 20, alignment: .center)
            Button(action: {
                isShow = false
            }, label: {
                Text("OK")
                    .foregroundColor(.white)
            }).frame(width: 100, height: 40, alignment: .center)
            .background(Color(UIColor.ColorFF88A7))
            .cornerRadius(20)
        }
        .padding([.top, .bottom])
        .background(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(Color.black, lineWidth: 2.0))
        .padding()
    }
    
    private func getRoomName(by id: String) -> String {
        return MeetingRoomService.shared.getAllRoomInfos().filter({ $0.roomID == id })[0].name
    }
}

struct BookedRoomDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        BookedRoomDetailInfo(bookedInfo: BookedRoom(employeeID: "", account: "TuanHA24", roomID: "", date: "09-Nov-2020", startTime: 15, endTime: 16, title: "Testing"), isShow: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
