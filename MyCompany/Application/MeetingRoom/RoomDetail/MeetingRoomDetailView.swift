//
//  MeetingRoomDetailView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/3/20.
//

import SwiftUI

struct MeetingRoomDetailView: View {
    var roomInfo: MeetingRoom
    @ObservedObject var viewModel: MeetingRoomDetailViewModel = MeetingRoomDetailViewModel()
    let bookingRoomViewModel = BookingRoomViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Search Room", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                
                ScrollView {
                    Image("meetingroom")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width / 2)
                    
                    VStack {
                        HStack {
                            Text("Room")
                            Spacer()
                        }.padding([.leading, .trailing, .top])
                        
                        HStack {
                            Text(roomInfo.name)
                            Spacer()
                        }.padding([.leading, .trailing])
                        
                        MeetingRoomDetailCell(title: "Polycom", imageName: "icon_room_polycom", content: roomInfo.polycom)
                        MeetingRoomDetailCell(title: "Location", imageName: "icon_room_location", content: roomInfo.location)
                        MeetingRoomDetailCell(title: "Building", imageName: "icon_room_building", content: roomInfo.building)
                        
                        HStack(alignment: .top) {
                            Text("Seats")
                            Spacer()
                            Text("\(roomInfo.maxSeats)")
                                .font(Font.system(size: 50))
                        }.padding()
                    }.background(Color(UIColor.ColorE9E9E9))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 4, x: 0, y: 0)
                    .padding()
                    
                    Spacer()
                }
                
                Button(action: {
                    viewModel.fetchBookedInfo(of: roomInfo.roomID,
                                              date: Date().convertToFormat(format: .iso))
                }, label: {
                    Text("BOOK NOW")
                        .foregroundColor(.white)
                })
                .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                .frame(width: UIScreen.main.bounds.width - 32)
                .background(Color(UIColor.ColorFF88A7))
                .cornerRadius(30.0)
                .padding()
                
                NavigationLink(
                    destination: LazyView(SearchRoomAvailableView(rooms: [roomInfo], timesValue: viewModel.getAllTimesValue(), bookedInfo: viewModel.bookedInfos, selectedDate: Date().convertToFormat(format: .iso)).environmentObject(bookingRoomViewModel)),
                    isActive: $viewModel.onFetchedBookedInfoSuccess, label: {
                        
                    })
            }
            
            if viewModel.onShowProgress {
                CustomProgressView()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct MeetingRoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomDetailView(roomInfo: MeetingRoom(name: "London", polycom: "42.112.193.3", location: "FPT Cau Giay", building: "FHN", maxSeats: 8))
    }
}
