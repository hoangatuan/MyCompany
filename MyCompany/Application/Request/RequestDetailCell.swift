//
//  RequestDetailCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/11/20.
//

import SwiftUI

enum StatusRequest: Int, CaseIterable {
    case pending = 0
    case approve = 1
    case deny = 2
    
    func toString() -> String {
        switch self {
        case .pending:
            return "Pending..."
        case .approve:
            return "Approved"
        case .deny:
            return "Denied"
        }
    }
}

struct RequestDetailCell: View {
    @State private var goToEditRequestView: Bool = false
    var request: Request
    let isAdmin: Bool = UserDataDefaults.shared.isAdministrator
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(
                destination: ApproveRequestView(request: request, isEditable: request.status == 0),
                isActive: $goToEditRequestView,
                label: {
                    
                })
            
            ZStack {
                HStack(spacing: 8) {
                    HStack {
                        Text("From")
                        Text(request.startDate)
                            .bold()
                        Spacer()
                    }.frame(maxWidth: .infinity)
                    
                    HStack {
                        Text("To")
                        Text(request.endDate)
                            .bold()
                        Spacer()
                    }.frame(maxWidth: .infinity)
                }.padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
                
                if isAdmin {
                    HStack {
                        let image = request.status == 0 ? "icon_request_edit" : "icon_request_moreinfo"
                        Spacer()
                        Button(action: {
                            goToEditRequestView = true
                        }, label: {
                            Image(image)
                                .resizable()
                                .frame(width: 40, height: 40)
                        })
                    }
                }
            }
            
            Divider().frame(height: 2, alignment: .center).background(Color.gray)
            
            if isAdmin {
                RequestDetailContentCell(title1: "Account", content1: request.account,
                                         title2: "Fullname", content2: request.fullName)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16))
            }
            
            RequestDetailContentCell(title1: "Request Type", content1: request.requestType,
                                     title2: "Partial Day", content2: request.partialDay)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16))
            RequestDetailContentCell(title1: "Reason", content1: request.reason,
                                     title2: "Reason Detail", content2: request.reasonDetail)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16))
            RequestDetailContentCell(title1: "Status", content1: getRequestStatus(status: request.status),
                                     title2: "Approve Date", content2: request.approveDate)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16))
            LeadingText(text: "Request's note")
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
            Text(request.approveNote)
                .bold()
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            
        }.background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: .gray, radius: 4, x: 0, y: 2))
    }
    
    private func getRequestStatus(status: Int) -> String {
        let statusRequest = StatusRequest(rawValue: status)
        return statusRequest?.toString() ?? ""
    }
}

struct RequestDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailCell(request: Request(requestType: "Nghi phep",
                                           account: "", fullName: "",
                                           imageURL: "",
                                           startDate: "12-Nov-2020", endDate: "13-Nov-2020", partialDay: "ca ngay",
                                           reason: "Di hoc", reasonDetail: "",
                                           status: 0, approveDate: "14-Nov-2020", approveNote: "OK"))
//            .previewLayout(.sizeThatFits)
    }
}
