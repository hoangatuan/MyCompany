//
//  EmployeeCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/28/20.
//

import Foundation

class EmployeeCellViewModel: ObservableObject {
    @Published var avatarImage: UIImage! = UIImage(named: "no_img")
    var employeeInfo: Employee
    var selecetedEmployee: Employee
    
    init(employeeInfo: Employee, selectedEmployee: Employee) {
        self.employeeInfo = employeeInfo
        self.selecetedEmployee = selectedEmployee
    }
    
    func loadAvasImage() {
        ImageDownloader.startDownloadImage(urlString: employeeInfo.avatarImageURL, identifier: employeeInfo.employeeID, type: .avatarImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: self.employeeInfo.employeeID, type: .avatarImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.avatarImage = image
            }
        })
    }
    
    func updateSelectedEmployeeProperty() {
        selecetedEmployee.address = employeeInfo.address
        selecetedEmployee.telephone = employeeInfo.telephone
        selecetedEmployee.email = employeeInfo.email
        selecetedEmployee.jobRank = employeeInfo.jobRank
        selecetedEmployee.contractStartDate = employeeInfo.contractStartDate
        selecetedEmployee.contractEndDate = employeeInfo.contractEndDate
        selecetedEmployee.avatarImageURL = employeeInfo.avatarImageURL
        selecetedEmployee.fullname = employeeInfo.fullname
        selecetedEmployee.employeeID = employeeInfo.employeeID
    }
}
