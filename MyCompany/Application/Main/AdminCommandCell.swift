//
//  AdminCommandCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/1/20.
//

import SwiftUI

enum AdminCommandType: String {
    case none
    case searchRequest = "Search Request"
    case approveRequest = "Approve Now"
    case updateInfo = "Update Info"
    case exchangeRequest = "Coin Request"
}

struct AdminCommandCell: View {
    var imageName: String
    var command: AdminCommandType
    var description: String
    var color: UIColor
    
    @Binding var selectedCommand: AdminCommandType
    
    var body: some View {
        VStack {
            Button(action: {
                selectedCommand = command
            }, label: {
                VStack(alignment: .leading) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                    
                    Text(command.rawValue)
                        .foregroundColor(.white)
                        .font(Font.system(size: 20))
                        .bold()
                    
                    Text(description)
                        .foregroundColor(.white)
                        .font(Font.system(size: 16))
                        .lineLimit(3)
                        .padding(.top, 8)
                }
                .padding()
                .background(Color(color))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 4, x: 0.0, y: 0.0)
            })
        }
    }
}

struct AdminCommandCell_Previews: PreviewProvider {
    static var previews: some View {
        AdminCommandCell(imageName: "", command: .approveRequest,
                         description: "Search all approved, pending or denied requests of all employees", color: .clear, selectedCommand: .constant(.approveRequest))
            .previewLayout(.sizeThatFits)
    }
}
