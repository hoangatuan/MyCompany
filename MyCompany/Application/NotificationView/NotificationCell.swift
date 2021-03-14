//
//  NotificationCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/2/20.
//

import SwiftUI

struct NotificationCell: View {
    var request: Request
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                let imageName = getIconName(status: request.status)
                Image(imageName)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .padding(.all, 8)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text(request.approveDate)
                        .foregroundColor(.gray)
                    Text(request.requestType)
                        .foregroundColor(.black)
                    Text(getRequestStatusDescription(status: request.status))
                        .foregroundColor(.black)
                    if !request.approveNote.isEmpty {
                        Text(request.approveNote)
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.all, 8)
        .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(Color.gray, lineWidth: 2.0))
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 0, trailing: 8))
    }
    
    private func getRequestStatusDescription(status: Int) -> String {
        let statusRequest = StatusRequest(rawValue: status) ?? .deny
        switch statusRequest {
        case .approve:
            return "This request has been approved!"
        case .deny:
            return "This request has been denied!"
        default:
            return ""
        }
    }
    
    private func getIconName(status: Int) -> String {
        let statusRequest = StatusRequest(rawValue: status) ?? .deny
        switch statusRequest {
        case .approve:
            return "icon_request_approved"
        case .deny:
            return "icon_request_denied"
        default:
            return ""
        }
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static let request: Request = Request(requestType: "Work From Home - Covid 19", account: "",
                                          fullName: "",
                                          imageURL: "", startDate: "", endDate: "", partialDay: "",
                                          reason: "", reasonDetail: "", status: 1, approveDate: "1-Dec-2020", approveNote: "")
    static var previews: some View {
        NotificationCell(request: request)
//            .previewLayout(.sizeThatFits)
    }
}
