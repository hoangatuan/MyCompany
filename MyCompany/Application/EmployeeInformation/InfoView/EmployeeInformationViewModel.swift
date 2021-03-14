//
//  EmployeeInformationViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/11/20.
//

import UIKit

final class EmployeeInformationViewModel: ObservableObject {
    enum State {
        case success
        case fail
    }
    
    @Published var infoPresentData: [EmployeePresentData] = []
    @Published var contactInfomationData: [EmployeePresentData] = []
    @Published var contractInfomationData: [EmployeePresentData] = []
    
    @Published var avatarURL: String = ""
    @Published var employeeFullname: String = ""
    @Published var onShowAlert: Bool = false
    @Published var onShowProgress: Bool = false
    
    var updateState: State = .fail
    var errorMessage: String = ""
    var employeeInfo: Employee?
    
    init(employeeInfo: Employee?) {
        self.employeeInfo = employeeInfo
        
        if let info = employeeInfo {
            updateInfoValues(info: info)
            avatarURL = info.avatarImageURL
            employeeFullname = info.fullname
        }
    }

    func requestEmployeeInformation() {
        if employeeInfo != nil {
            return
        }
        
        onShowProgress = true
        EmployeeService.shared.getEmployeeInfo { [weak self] (employeeInfo) in
            self?.onShowProgress = false
            guard let info = employeeInfo else {
                return
            }
            
            self?.avatarURL = info.avatarImageURL
            self?.employeeFullname = info.fullname
            self?.updateInfoValues(info: info)
        } onError: { [weak self] error in
            self?.errorMessage = error.rawValue
            self?.updateState = .fail
            self?.onShowAlert = true
        }
    }
    
    private func updateInfoValues(info: Employee) {
        infoPresentData = [
            EmployeePresentData(title: "Full name", content: info.fullname),
            EmployeePresentData(title: "Date of birth", content: info.dob),
            EmployeePresentData(title: "Gender", content: info.gender),
            EmployeePresentData(title: "Job Family", content: info.jobFamily),
            EmployeePresentData(title: "National ID", content: info.nationalID),
            EmployeePresentData(title: "Department", content: info.department),
        ]
        
        contactInfomationData = [
            EmployeePresentData(title: "Address", content: info.address, editStyle: .text),
            EmployeePresentData(title: "Telephone", content: info.telephone, editStyle: .number),
            EmployeePresentData(title: "Email", content: info.email, editStyle: .text)
        ]
        
        contractInfomationData = [
            EmployeePresentData(title: "Job rank", content: info.jobRank, editStyle: .dropdown),
            EmployeePresentData(title: "Contract Start Date", content: info.contractStartDate, editStyle: .date),
            EmployeePresentData(title: "Contract End Date", content: info.contractEndDate, editStyle: .date)
        ]
    }
    
    func updateEmployeeInfo() {
        let employeeUpdateData = EmployeeUpdatableData(employeeID: employeeInfo?.employeeID ?? "", address: contactInfomationData[0].content,
                                                       telephone: contactInfomationData[1].content, email: contactInfomationData[2].content,
                                                       jobRank: contractInfomationData[0].content, contractStartDate: contractInfomationData[1].content,
                                                       contractEndDate: contractInfomationData[2].content)
        
        EmployeeService.shared.updateEmployeeInfo(with: employeeUpdateData, completion: { [weak self] data in
            self?.updateState = .success
            self?.onShowAlert = true
        }, onError: { [weak self] error in
            self?.errorMessage = error.rawValue
            self?.updateState = .fail
            self?.onShowAlert = true
        })
    }
}
