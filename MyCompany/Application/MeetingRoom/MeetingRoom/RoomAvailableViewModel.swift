//
//  RoomAvailableViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/7/20.
//

import Foundation

class RoomAvailableViewModel {
    func isBooked(bookedInfos: [BookedRoom], time: String) -> Bool {
        let timeDoubleValue: Double = Converter.convertTimeFromStringToDouble(timeValue: time)
        for info in bookedInfos {
            if timeDoubleValue >= info.startTime && timeDoubleValue < info.endTime {
                return true
            }
        }
        
        return false
    }
    
    func getBookedInfo(at time: String, bookedInfos: [BookedRoom]) -> BookedRoom {
        let timeDoubleValue: Double = Converter.convertTimeFromStringToDouble(timeValue: time)
        return bookedInfos.filter({ timeDoubleValue >= $0.startTime && timeDoubleValue <= $0.endTime })[0]
    }
    
    func isSecondTimeSelectedAvailable(firstTime: String, secondTime: String, bookedInfo: [BookedRoom]) -> Bool {
        let expectTimeValues = generateTimesValue(startTime: firstTime, endTime: secondTime)
        var bookedTime: [String] = []
        
        for info in bookedInfo {
            let startTime = Converter.convertTimeFromDoubleToString(timeValue: info.startTime)
            let endTime = Converter.convertTimeFromDoubleToString(timeValue: info.endTime)
            bookedTime += generateTimesValue(startTime: startTime, endTime: endTime)
            bookedTime.removeLast() // Remove end time
        }
        
        for time in bookedTime {
            if expectTimeValues.contains(time) {
                return false
            }
        }
        
        return true
    }
    
    func generateTimesValue(startTime: String, endTime: String) -> [String] {
        if startTime == "" && endTime == "" {
            return []
        }
        
        if startTime == "" {
            return [endTime]
        }
        
        if endTime == "" {
            return [startTime]
        }
        
        var start = Converter.convertTimeFromStringToDouble(timeValue: startTime)
        var end = Converter.convertTimeFromStringToDouble(timeValue: endTime)
        
        if start > end {
            swap(&start, &end)
        }
        
        let timeStringValues = stride(from: start, through: end, by: 0.5)
            .map({ Converter.convertTimeFromDoubleToString(timeValue: $0) })
        
        return timeStringValues
    }
    
    func generateEndBookTime(startTime: String, endTime: String) -> String {
        if startTime == "" {
            return ""
        }
        
        if endTime == "" {
            let startTimeDoubleValue = Converter.convertTimeFromStringToDouble(timeValue: startTime)
            let endTimeDoubleValue = startTimeDoubleValue + 0.5
            
            return Converter.convertTimeFromDoubleToString(timeValue: endTimeDoubleValue)
        }
        
        let endTimeDoubleValue = Converter.convertTimeFromStringToDouble(timeValue: endTime)
        return Converter.convertTimeFromDoubleToString(timeValue: endTimeDoubleValue + 0.5)
    }
}
