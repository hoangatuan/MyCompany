//
//  RequestDetailContentCell.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/11/20.
//

import SwiftUI

struct RequestDetailContentCell: View {
    var title1: String
    var content1: String
    var title2: String
    var content2: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading) {
                LeadingText(text: title1)
                HStack {
                    if content1 == "Approved" {
                        Image("icon_request_approve")
                            .resizable()
                            .frame(width: 32, height: 32)
                    } else if content1 == "Pending..." {
                        Image("icon_request_inprogress")
                    } else if content1 == "Denied" {
                        Image("icon_request_deny")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    
                    Text(content1)
                        .bold()
                }
            }.frame(maxWidth: .infinity)
            
            VStack(alignment: .leading) {
                LeadingText(text: title2)
                Text(content2)
                    .bold()
            }.frame(maxWidth: .infinity)
        }
    }
}

struct RequestDetailContentCell_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailContentCell(title1: "Status", content1: "Phê duyệt", title2: "Approve Date", content2: "20/1/2020").previewLayout(.sizeThatFits)
    }
}
