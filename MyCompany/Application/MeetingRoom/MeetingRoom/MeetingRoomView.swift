//
//  MeetingRoomView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/4/20.
//

import SwiftUI

struct MeetingRoomView: View {
    @State private var isPresentSearchView: Bool = false
    @State private var isPolycomOnly: Bool = false
    @State private var numberOfSeats: String = ""
    
    @State private var location: String = "Prague, Prague, Ha Noi"
    @State private var roomName: String = "All"
    @State private var startTime: String = "07:00"
    @State private var endTime: String = "07:30"
    @State private var selectedDate: Date = Date()
    @State private var isShowBookedHistory: Bool = false
    
    @ObservedObject var viewModel: MeetingRoomViewModel
    let bookingRoomViewModel = BookingRoomViewModel()
    
    init() {
        viewModel = MeetingRoomViewModel()
        viewModel.fetchAllMeetingRoomsFromServer()
    }
    
    var body: some View {
        VStack {
            CustomRightActionNavBar(navBarTitle: "Meeting Room", isShowBackButton: false, rightButtonTitle: "History", actionRightButton: {
                isShowBookedHistory = true
            })
            
            NavigationLink(
                destination: BookedHistoryView(),
                isActive: $isShowBookedHistory,
                label: {
                    
                })
            
            ZStack {
                ScrollView {
                    ZStack {
                        Image("meetingroom")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.width / 2)
                        
                        NavigationLink(
                            destination: MeetingRoomSearchView(),
                            isActive: $isPresentSearchView,
                            label: {
                                HStack {
                                    Text("Find room information...")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)
                                }.padding()
                                .background(BlurView(style: .light))
                                .cornerRadius(10.0)
                                .padding()
                            })
                    }
                    
                    LeadingText(text: "Address")
                        .padding([.top, .leading, .trailing])
                    
                    VStack {
                        HStack {
                            Toggle(isOn: $isPolycomOnly, label: {
                                Text("Polycom only")
                            }).frame(width: 170)
                            .toggleStyle(SwitchToggleStyle(tint: .orange))
                            
                            Spacer()
                            
                            CustomTextField(inputText: $numberOfSeats, currentText: "", keyboardType: .numberPad, placeHolder: "No. of seats", isAutoShowKeyboard: false, onCompleteEditing: { _ in })
                            .frame(width: 150)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(Color.gray, lineWidth: 2.0))
                        }
                        
                        DropdownButton(defaultValue: $location, title: "Select Location", values: viewModel.getAllLocationDescription())
                        DropdownButton(defaultValue: $roomName, title: "Select Room", values: viewModel.getAllRoomNameByLocation(location: location))
                    }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.gray, lineWidth: 2.0))
                    .padding([.leading, .trailing])
                    
                    LeadingText(text: "Booking time")
                        .padding([.top, .leading, .trailing])
                    
                    VStack {
                        Button(action: {
                            
                        }, label: {
                            HStack {
                                DatePickerView(date: $selectedDate, dateDidChange: {})
                                Spacer()
                            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(Color.gray, lineWidth: 2.0))
                        })
                        
                        HStack(spacing: 16.0) {
                            DropdownButton(defaultValue: $startTime, title: "Select Start Time", values: viewModel.startTimeValues)
                                .onChange(of: startTime, perform: { value in
                                    handleIfStartTimeGreaterThanEndTime()
                            })
                            DropdownButton(defaultValue: $endTime, title: "Select End Time", values: viewModel.endTimeValues)
                                .onChange(of: endTime, perform: { value in
                                    handleIfEndTimeSmallerThanEndTime()
                                })
                        }
                    }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.gray, lineWidth: 2.0))
                    .padding([.leading, .trailing, .bottom])
                    
                    Button(action: {
                        didTapButtonSearch()
                    }, label: {
                        Text("Search")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 8.0, leading: 0, bottom: 8.0, trailing: 0))
                    }).frame(width: UIScreen.main.bounds.width - 32)
                    .background(Color(UIColor.ColorFF88A7))
                    .cornerRadius(30.0)
                    .padding()
                    
                    NavigationLink(destination: SearchRoomAvailableView(rooms: viewModel.getAllSelectRoomByName(name: roomName, location: location,
                                                                                                                isHavePolycom: isPolycomOnly,
                                                                                                                minimumSeats: numberOfSeats),
                                                                        timesValue: viewModel.generateTimesValue(startTime: startTime, endTime: endTime),
                                                                        bookedInfo: viewModel.bookedInfos,
                                                                        selectedDate: selectedDate.convertToFormat(format: .iso)).environmentObject(bookingRoomViewModel),
                                   isActive: $viewModel.onFetchedBookedInfoSuccess, label: {
                        
                    })
                }
                
                if viewModel.onShowProgress {
                    CustomProgressView()
                }
            }
        }
    }
    
    private func didTapButtonSearch() {
        if roomName == "All" {
            viewModel.fetchAllBookedInfo(date: selectedDate.convertToFormat(format: .iso))
        } else {
            viewModel.fetchBookedInfo(of: viewModel.getRoomIdByName(roomName: roomName),
                                      date: selectedDate.convertToFormat(format: .iso))
        }
    }
    
    private func handleIfStartTimeGreaterThanEndTime() {
        let startTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: startTime)
        let endTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: endTime)
        
        if startTimeDouble > endTimeDouble {
            endTime = startTime
        }
        
        viewModel.endTimeValues = viewModel.generateTimesValue(startTime: startTime, endTime: "19:00")
    }
    
    private func handleIfEndTimeSmallerThanEndTime() {
        let startTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: startTime)
        let endTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: endTime)
        
        if endTimeDouble < startTimeDouble {
            startTime = endTime
        }
    }
}

struct MeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomView()
    }
}
