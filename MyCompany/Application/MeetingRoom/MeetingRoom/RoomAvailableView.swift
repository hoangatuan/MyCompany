//
//  RoomAvailableView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/7/20.
//

import SwiftUI

struct RoomAvailableView: View {
    @Binding var isShowBookedInfoView: Bool 
    @Binding var selectedBookedInfo: BookedRoom
    @State private var firstTimeSelected: String = ""
    @State private var secondTimeSelected: String = ""
    @State private var isShowBookingView: Bool = false
    @EnvironmentObject var bookingViewModel: BookingRoomViewModel
    
    var selectedDate: String
    let meetingRoom: MeetingRoom
    let datas: [String]
    let bookedInfo: [BookedRoom]
    let viewModel: RoomAvailableViewModel = RoomAvailableViewModel()
    
    var body: some View {
        VStack {
            LeadingText(text: meetingRoom.name)
            LeadingText(text: meetingRoom.location)
            Divider().frame(height: 1)
                .padding(.bottom)
            
            let fourColumnsGrid: [GridItem] = Array.init(repeating: .init(.flexible()), count: 4)
            LazyVGrid(columns: fourColumnsGrid,spacing: 20) {
                ForEach(0..<datas.count, id: \.self) { index in
                    Button(action: {
                        didTapToTimer(at: index)
                    }, label: {
                        Text(datas[index])
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(getForegroundColor(at: index))
                    })
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                    .background(getBackgroundColor(at: index))
                    .cornerRadius(10.0)
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color(UIColor.ColorFF88A7), lineWidth: viewModel.isBooked(bookedInfos: bookedInfo,
                                                                                  time: datas[index]) ? 0.0 : 2.0))
                }
            }
            
            Divider().frame(height: 1)
                .padding(.top)
            HStack {
                Spacer()
                Button(action: {
                    isShowBookingView = true
                }, label: {
                    let textColor: Color = isBookButtonDisable() ? .gray : Color(UIColor.ColorFF88A7)
                    Text("Book")
                        .foregroundColor(textColor)
                }).disabled(isBookButtonDisable())
                .frame(width: 80, height: 30)
                .overlay(RoundedRectangle(cornerRadius: 15.0)
                            .stroke(firstTimeSelected == "" && secondTimeSelected == "" ? Color.gray : Color(UIColor.ColorFF88A7),
                                    lineWidth: 2.0))
            }
            
            NavigationLink(
                destination: LazyView(BookingRoomView(meetingRoom: meetingRoom, selectedDate: selectedDate,
                                                      startTime: firstTimeSelected,
                                                      endTime: viewModel.generateEndBookTime(startTime: firstTimeSelected,
                                                                                             endTime: secondTimeSelected),
                                                      viewModel: bookingViewModel)),
                isActive: $isShowBookingView,
                label: {
                    // Nothing
                })
        }.padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
        .overlay(RoundedRectangle(cornerRadius: 20.0)
                    .stroke(Color.gray, lineWidth: 2.0))
        .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
        .navigationBarTitle("", displayMode: .inline)
    }
    
    private func sortStartTimeAndEndTime() {
        let startTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: firstTimeSelected)
        let endTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: secondTimeSelected)

        if startTimeDouble > endTimeDouble {
            firstTimeSelected = Converter.convertTimeFromDoubleToString(timeValue: endTimeDouble)
            secondTimeSelected = Converter.convertTimeFromDoubleToString(timeValue: startTimeDouble)
        }
    }
    
    private func didTapToTimer(at index: Int) {
        if viewModel.isBooked(bookedInfos: bookedInfo, time: datas[index]) {
            selectedBookedInfo = viewModel.getBookedInfo(at: datas[index], bookedInfos: bookedInfo)
            isShowBookedInfoView = true
        } else {
            handleSelectNewTimer(at: index)
        }
    }
    
    private func handleSelectNewTimer(at index: Int) {
        if firstTimeSelected != "" && secondTimeSelected != "" {
            firstTimeSelected = datas[index]
            secondTimeSelected = ""
            return
        }
        
        if firstTimeSelected == "" {
            firstTimeSelected = datas[index]
            return
        }
        
        if firstTimeSelected == datas[index] {
            firstTimeSelected = ""
            return
        }
        
        if viewModel.isSecondTimeSelectedAvailable(firstTime: firstTimeSelected,
                                                   secondTime: datas[index],
                                                   bookedInfo: bookedInfo) {
            secondTimeSelected = datas[index]
        }
        
        sortStartTimeAndEndTime()
    }
    
    private func getBackgroundColor(at index: Int) -> Color {
        if viewModel.isBooked(bookedInfos: bookedInfo, time: datas[index]) {
            return Color.gray
        }
        
        let expectedTimes = viewModel.generateTimesValue(startTime: firstTimeSelected, endTime: secondTimeSelected)
        return expectedTimes.contains(datas[index]) ? Color(UIColor.ColorFF88A7) : Color.clear
    }
    
    private func getForegroundColor(at index: Int) -> Color {
        if viewModel.isBooked(bookedInfos: bookedInfo, time: datas[index]) {
            return .black
        }
        
        let expectedTimes = viewModel.generateTimesValue(startTime: firstTimeSelected, endTime: secondTimeSelected)
        return expectedTimes.contains(datas[index]) ? Color.white : Color(UIColor.ColorFF88A7)
    }
    
    private func isBookButtonDisable() -> Bool {
        firstTimeSelected == "" && secondTimeSelected == ""
    }
}

struct RoomAvailableView_Previews: PreviewProvider {
    static var previews: some View {
        RoomAvailableView(isShowBookedInfoView: .constant(false),
                          selectedBookedInfo: .constant(BookedRoom(employeeID: "", account: "", roomID: "", date: "", startTime: 0, endTime: 0, title: "")), selectedDate: "",
                          meetingRoom: MeetingRoom(name: "London", polycom: "", location: "FVille 1, 1st floor", building: "FHL", maxSeats: 20),
                          datas: ["17:00", "17:30", "18:00", "18:30", "17:00", "17:30", "18:00", "18:30"],
                          bookedInfo: [])
            .previewLayout(.sizeThatFits)
    }
}
