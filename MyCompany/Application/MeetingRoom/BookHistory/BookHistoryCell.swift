//
//  BookHistoryCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/17/20.
//

import SwiftUI

struct BookHistoryCell: View {
    var bookedInfo: BookedRoom
    var meetingRoom: MeetingRoom
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8, content: {
                VStack {
                    HStack {
                        Image("icon_room_room")
                            .resizable().frame(width: 24, height: 24, alignment: .center)
                        Text("Room name: ")
                            .bold()
                        
                        Spacer()
                        
                        Text(meetingRoom.name)
                    }
                    
                    HStack {
                        Image("icon_room_location")
                            .resizable().frame(width: 24, height: 24, alignment: .center)
                        Text("Location: ")
                            .bold()
                        Spacer()
                        Text(meetingRoom.location)
                    }
                    
                    HStack {
                        Image("icon_room_calendar")
                            .resizable().frame(width: 24, height: 24, alignment: .center)
                        Text("Date: ")
                            .bold()
                        Spacer()
                        Text(bookedInfo.date)
                    }
                }
                
                RequestDetailContentCell(title1: "Start time", content1: Converter.convertTimeFromDoubleToString(timeValue: bookedInfo.startTime),
                                         title2: "End time", content2: Converter.convertTimeFromDoubleToString(timeValue: bookedInfo.endTime))
                VStack(alignment: .leading, spacing: 0.0) {
                    Text("Title")
                        .bold()
                    Text(bookedInfo.title)
                }
            }).padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 0)
        }
    }
}

struct BookHistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        BookHistoryCell(bookedInfo: BookedRoom(employeeID: "", account: "", roomID: "", date: "14-Nov-2020",
                                               startTime: 8, endTime: 8.5, title: "Daily Meeting 123456"),
                        meetingRoom: MeetingRoom(name: "Ngoc Ha", polycom: "", location: "Fville 1",
                                                 building: "", maxSeats: 0))
    }
}
