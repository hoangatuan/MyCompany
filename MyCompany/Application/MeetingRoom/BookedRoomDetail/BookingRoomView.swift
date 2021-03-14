//
//  BookingRoomView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/8/20.
//

import SwiftUI

struct BookingRoomView: View {
    @State private var titleText: String = ""
    @ObservedObject var viewModel: BookingRoomViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var meetingRoom: MeetingRoom
    var selectedDate: String
    var startTime: String
    var endTime: String
    
    init(meetingRoom: MeetingRoom, selectedDate: String, startTime: String, endTime: String, viewModel: BookingRoomViewModel) {
        self.meetingRoom = meetingRoom
        self.selectedDate = selectedDate
        self.startTime = startTime
        self.endTime = endTime
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Meeting Room", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                VStack {
                    HStack {
                        HeaderBookingRoomView(title: "Room", content: meetingRoom.name)
                        HeaderBookingRoomView(title: "Polycom", content: meetingRoom.polycom)
                        HeaderBookingRoomView(title: "Seats", content: "\(meetingRoom.maxSeats)")
                    }.padding(.bottom)
                    
                    HStack {
                        Image("icon_room_building")
                            .resizable().frame(width: 24, height: 24, alignment: .center)
                        Text("Building")
                            .bold()
                        Spacer()
                    }
                    
                    LeadingText(text: meetingRoom.building)
                    
                    Divider().frame(height: 1)
                    Group {
                        HStack {
                            Image("icon_room_location")
                                .resizable().frame(width: 24, height: 24, alignment: .center)
                            Text("Location")
                                .bold()
                            Spacer()
                        }
                        
                        LeadingText(text: meetingRoom.location)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 48, trailing: 0))
                    }
                    
                    HStack {
                        VStack(alignment: .leading, content: {
                            HStack {
                                Image("icon_room_calendar")
                                    .resizable()
                                    .frame(width: 24, height: 24, alignment: .center)
                                Text("Date")
                                    .bold()
                                Spacer()
                            }
                            
                            Text(selectedDate)
                        }).frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading, content: {
                            HStack {
                                Image("icon_room_clock")
                                    .resizable()
                                    .frame(width: 24, height: 24, alignment: .center)
                                Text("Time")
                                    .bold()
                                Spacer()
                            }
                            Text("\(startTime) - \(endTime)")
                        }).frame(maxWidth: .infinity)
                    }
                    
                    TextField("Title*", text: $titleText)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color.gray, lineWidth: 2.0))
                        .padding([.top, .bottom])
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.createNewBookRequest(roomID: meetingRoom.roomID,
                                                       date: selectedDate,
                                                       startTime: startTime, endTime: endTime,
                                                       title: titleText)
                    }, label: {
                        Text("Book")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                    }).frame(width: UIScreen.main.bounds.width - 32)
                    .background(Color(UIColor.ColorFF88A7))
                    .cornerRadius(30.0)
                    .padding([.top, .bottom])
                    
                }.padding()
            }
            
            .alert(isPresented: $viewModel.onShowAlert, content: {
                let title: String = viewModel.response.rawValue
                
                return Alert(title: Text(title), message: nil, dismissButton: Alert.Button.default(Text("OK"), action: {
                    if viewModel.response != .inputEmpty {
                        presentationMode.wrappedValue.dismiss()
                    }
                }))
            })
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct BookingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        BookingRoomView(meetingRoom: MeetingRoom(name: "Ngoc Ha", polycom: "N/A", location: "FVille 1, 2nd Fllor W3", building: "FVille 1, FHL", maxSeats: 30),
                        selectedDate: "10-Nov-2020",
                        startTime: "11:30",
                        endTime: "12:00", viewModel: BookingRoomViewModel())
    }
}
