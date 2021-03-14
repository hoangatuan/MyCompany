//
//  MeetingRoomView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/3/20.
//

import SwiftUI

struct MeetingRoomSearchView: View {
    @State private var searchText: String = ""
    @ObservedObject var viewModel: MeetingRoomSearchViewModel
    @State private var isPush: Bool = false
    
    init() {
        viewModel = MeetingRoomSearchViewModel()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image("meetingroom")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width / 2)
                    
                    SearchBar(inputText: $searchText, placeHolder: "Find room information...", isWhiteBackground: true)
                        .background(Color.white.cornerRadius(10.0))
                        .padding([.leading, .trailing])
                        .onChange(of: searchText, perform: { value in
                            print("search for value: \(value)")
                            viewModel.searchForMeetingRoom(with: value)
                        })
                }
                
                ForEach(viewModel.matchedRoom) { roomInfo in
                    NavigationLink(
                        destination: MeetingRoomDetailView(roomInfo: roomInfo),
                        isActive: $isPush,
                        label: {
                            MeetingRoomCell(roomInfo: roomInfo)
                        })
                }
                
                Spacer()
            }.navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct MeetingRoomSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomSearchView()
    }
}
