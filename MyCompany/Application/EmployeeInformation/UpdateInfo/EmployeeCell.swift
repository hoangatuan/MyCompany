//
//  EmployeeCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/28/20.
//

import SwiftUI

struct EmployeeCell: View {
    var viewModel: EmployeeCellViewModel
    @Binding var onShowUpdateView: Bool
    
    init(employeeInfo: Employee, onShowUpdateView: Binding<Bool>, selectedEmployee: Employee) {
        viewModel = EmployeeCellViewModel(employeeInfo: employeeInfo, selectedEmployee: selectedEmployee)
        _onShowUpdateView = onShowUpdateView
        
        viewModel.loadAvasImage()
    }
    
    var body: some View {
        HStack {
            Image(uiImage: viewModel.avatarImage)
                .resizable().frame(width: 60, height: 60, alignment: .center)
                .clipShape(Circle())
                .padding()
            
            VStack(alignment: .leading) {
                Text(viewModel.employeeInfo.fullname)
                    .bold()
                Text(viewModel.employeeInfo.account)
                Text(viewModel.employeeInfo.department)
                    .foregroundColor(Color(UIColor.gray))
            }
            
            Spacer()
            
            Button(action: {
                viewModel.updateSelectedEmployeeProperty()
                onShowUpdateView = true
            }, label: {
                Image("icon_request_edit")
                    .resizable().frame(width: 32, height: 32, alignment: .center)
                    .padding(.horizontal, 8)
            })
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
        .padding(.horizontal, 8)
    }
}

struct EmployeeCell_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeCell(employeeInfo: Employee(), onShowUpdateView: .constant(false), selectedEmployee: Employee())
            .previewLayout(.sizeThatFits)
    }
}
