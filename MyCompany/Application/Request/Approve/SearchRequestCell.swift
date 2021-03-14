//
//  SearchRequestCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/27/20.
//

import SwiftUI

struct SearchRequestCell: View {
    private var viewModel: SearchRequestCellViewModel
    @Binding var selectedRequest: Request
    
    init(request: Request, selectedRequest: Binding<Request>) {
        viewModel = SearchRequestCellViewModel(request: request)
        viewModel.loadAvasImage()
        
        _selectedRequest = selectedRequest
    }
    
    var body: some View {
        VStack {
            ZStack(alignment:.top) {
                HStack {
                    Image(uiImage: viewModel.avatarImage)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Account:")
                                .bold()
                            Text(viewModel.request.account)
                        }
                        
                        HStack {
                            Text("Request Type:")
                                .bold()
                            Text(viewModel.request.requestType)
                        }
                        
                        HStack {
                            Text("Status:")
                                .bold()
                            Text(StatusRequest(rawValue: viewModel.request.status)?.toString() ?? "")
                                .foregroundColor(getStatusColor(requestStatus: viewModel.request.status))
                        }
                        
                    }
                    
                    Spacer()
                }.padding()
                
                HStack {
                    Spacer()
                    let image = viewModel.request.status == 0 ? "icon_request_edit" : "icon_request_moreinfo"
                    Button(action: {
                        selectedRequest = viewModel.request
                    }, label: {
                        Image(image)
                            .resizable().frame(width: 40, height: 40, alignment: .center)
                    })
                }
            }
            
            DividerView()
        }
    }
    
    private func getStatusColor(requestStatus: Int) -> Color {
        let status = StatusRequest(rawValue: requestStatus) ?? .pending
        switch status {
        case .pending:
            return .blue
        case .approve:
            return .green
        case .deny:
            return .red
        }
    }
    
    private func convertIntToRequestStatus(status: Int) -> StatusRequest {
        return StatusRequest(rawValue: status) ?? .pending
    }
}

struct SearchRequestCell_Previews: PreviewProvider {
    static let mockRequest = Request(requestType: "Work From Home", account: "TuanHA24",
                                     fullName: "", imageURL: "", startDate: "", endDate: "", partialDay: "", reason: "", reasonDetail: "", status: 0, approveDate: "", approveNote: "")
    static var previews: some View {
        SearchRequestCell(request: mockRequest, selectedRequest: .constant(mockRequest))
            .previewLayout(.sizeThatFits)
    }
}
