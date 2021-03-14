//
//  SearchRoomAvailableView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/7/20.
//

import SwiftUI
import Combine

struct SearchRoomAvailableView: View {
    @State private var selectedBookedInfo: BookedRoom = BookedRoom(employeeID: "", account: "", roomID: "", date: "", startTime: 0, endTime: 0, title: "")
    @State private var isShowBookedInfoDetail: Bool = false
    @ObservedObject private var viewModel: SearchRoomAvailableViewModel
    
    init(rooms: [MeetingRoom], timesValue: [String], bookedInfo: [BookedRoom], selectedDate: String) {
        self.timesValue = timesValue
        self.selectedDate = selectedDate
        
        viewModel = SearchRoomAvailableViewModel(selectedDate: selectedDate, rooms: rooms, bookedInfos: bookedInfo)
    }
    
    var timesValue: [String]
    var selectedDate: String
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Meeting Room", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
                
                ScrollView {
                    let resultText = viewModel.rooms.count > 1 ? "results" : "result"
                    LeadingText(text: "There are \(viewModel.rooms.count) \(resultText) that match your search")
                        .padding([.leading, .trailing, .top])
                    
                    let oneColumnGrid = [GridItem(.flexible())]
                    LazyVGrid(columns: oneColumnGrid, spacing: 16) {
                        ForEach(0..<viewModel.rooms.count, id: \.self) { index in
                            RoomAvailableView(isShowBookedInfoView: $isShowBookedInfoDetail,
                                              selectedBookedInfo: $selectedBookedInfo,
                                              selectedDate: selectedDate,
                                              meetingRoom: viewModel.rooms[index],
                                              datas: timesValue,
                                              bookedInfo: getBookedInfoAvailable(for: viewModel.rooms[index].roomID))
                        }
                    }.padding()
                }
            }
            
            if isShowBookedInfoDetail {
                BookedRoomDetailInfo(bookedInfo: selectedBookedInfo, isShow: $isShowBookedInfoDetail)
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
    }
    
    private func getBookedInfoAvailable(for roomID: String) -> [BookedRoom] {
        let infoMatch = viewModel.bookedInfosFetch.filter({ $0.roomID == roomID })
        return infoMatch
    }
}

struct SearchRoomAvailableView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRoomAvailableView(rooms: [], timesValue: [], bookedInfo: [], selectedDate: "")
    }
}
