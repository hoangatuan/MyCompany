//
//  BookedHistoryView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/16/20.
//

import SwiftUI

struct BookedHistoryView: View {
    @ObservedObject var viewModel: BookHistoryViewModel
    
    init() {
        viewModel = BookHistoryViewModel()
        viewModel.getAllBookHistory()
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Meeting Room", isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
            
            ScrollView {
                Image("meetingroom")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.width / 2)
                
                let oneColumnGrid = [GridItem(.flexible())]
                LazyVGrid(columns: oneColumnGrid, spacing: 16) {
                    ForEach(0..<viewModel.bookHistory.count, id: \.self) {
                        let bookHistoryAtIndex = viewModel.bookHistory[$0]
                        BookHistoryCell(bookedInfo: bookHistoryAtIndex,
                                        meetingRoom: viewModel.getMeetingRoomInfo(of: bookHistoryAtIndex))
                    }
                }.padding()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct BookedHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BookedHistoryView()
    }
}
