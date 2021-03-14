//
//  MeetingRoomService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/3/20.
//

import Foundation

final class MeetingRoomService {
    static let shared = MeetingRoomService()
    private var allRoomInfos: [MeetingRoom] = []
    
    let timeValues: [String] = ["07:00",
                                "07:30",
                                "08:00",
                                "08:30",
                                "09:00",
                                "09:30",
                                "10:00",
                                "10:30",
                                "11:00",
                                "11:30",
                                "12:00",
                                "12:30",
                                "13:00",
                                "13:30",
                                "14:00",
                                "14:30",
                                "15:00",
                                "15:30",
                                "16:00",
                                "16:30",
                                "17:00",
                                "17:30",
                                "18:00",
                                "18:30",
                                "19:00",
    ]
    
    func getAllLocationDescriptionValues() -> [String] {
        var values: [String] = []
        for room in allRoomInfos {
            let locationDes = getLocationDescription(of: room)
            if !values.contains(locationDes) {
                values.append(locationDes)
            }
        }
        return values
    }
    
    func getLocationDescription(of room: MeetingRoom) -> String {
        let location = room.location.split(separator: ",").first ?? ""
        return String(location) + ", " + room.building
    }
    
    func getAllRoomByLocation(location: String) -> [MeetingRoom] {
        return allRoomInfos.filter({ getLocationDescription(of: $0) == location })
    }
    
    func getAllRoomInfos() -> [MeetingRoom] {
        return allRoomInfos
    }
    
    func getAllMeetingRoomInfo() {
        let rest = RestManager()
        let stringURL = RouterManager.GetAllMeetingRoomInfo
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if results.error != nil {
                return
            }
            
            guard let data = results.data else {
                return
            }
            
            do {
                self.allRoomInfos = try JSONDecoder().decode([MeetingRoom].self, from: data)
            } catch let error {
                debugPrint("Decode Meeting Room Failed - Error: \(error)")
            }
        }
    }
    
    func getBookedInfo(of roomID: String, date: String, completion: @escaping ([BookedRoom]) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetBookedRoomInfo + "\(roomID)" + "&date=" + "\(date)"
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if results.error != nil {
                return
            }
            
            guard let data = results.data else {
                return
            }
            
            do {
                let bookedInfos = try JSONDecoder().decode([BookedRoom].self, from: data)
                DispatchQueue.main.async {
                    completion(bookedInfos)
                }
            } catch let error {
                debugPrint("Decode Booked Info Failed - Error: \(error)")
            }
        }
    }
    
    func getAllBookedInfo(date: String, completion: @escaping ([BookedRoom]) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetAllBookedRoomInfo + "\(date)"
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.makeRequest(toURL: url, withHttpMethod: .get, completion: { results in
            if results.error != nil {
                return
            }
            
            guard let data = results.data else {
                return
            }
            
            do {
                let bookedInfos = try JSONDecoder().decode([BookedRoom].self, from: data)
                DispatchQueue.main.async {
                    completion(bookedInfos)
                }
            } catch let error {
                debugPrint("Decode Booked Info Failed - Error: \(error)")
            }
        })
    }
    
    func createBookRoomRequest(roomID: String, date: String, startTime: String, endTime: String, title: String, onStatus: @escaping (Int) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.CreateBookRequest
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        
        rest.httpBodyParameters.add(value: UserDataDefaults.shared.employeeID, forkey: "employeeID")
        rest.httpBodyParameters.add(value: roomID, forkey: "roomID")
        rest.httpBodyParameters.add(value: date, forkey: "date")
        rest.httpBodyParameters.add(value: startTime, forkey: "startTime")
        rest.httpBodyParameters.add(value: endTime, forkey: "endTime")
        rest.httpBodyParameters.add(value: title, forkey: "title")
        
        rest.makeRequest(toURL: url, withHttpMethod: .post, completion: { results in
            guard let statusCode = results.response?.httpStatusCode else {
                return
            }
            
            DispatchQueue.main.async {
                onStatus(statusCode)
            }
        })
    }
    
    func getAllBookHistory(completion: @escaping ([BookedRoom]) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetBookHistory + UserDataDefaults.shared.employeeID
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.makeRequest(toURL: url, withHttpMethod: .get, completion: { results in
            if results.error != nil {
                return
            }
            
            guard let data = results.data else {
                return
            }
            
            do {
                let bookedInfos = try JSONDecoder().decode([BookedRoom].self, from: data)
                DispatchQueue.main.async {
                    completion(bookedInfos)
                }
            } catch let error {
                debugPrint("Decode Booked Info Failed - Error: \(error)")
            }
        })
    }
}
